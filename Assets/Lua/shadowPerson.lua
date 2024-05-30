require "dreams"

targets = {
    GetEntity("ShadowTarget1").WorldPosition,
    GetEntity("ShadowTarget2").WorldPosition,
    GetEntity("ShadowTarget3").WorldPosition,
    GetEntity("ShadowTarget4").WorldPosition,
    GetEntity("ShadowTarget5").WorldPosition,
    GetEntity("ShadowTarget6").WorldPosition,
    GetEntity("ShadowTarget7").WorldPosition,
    GetEntity("ShadowTarget8").WorldPosition,
    GetEntity("ShadowTarget9").WorldPosition,
    GetEntity("ShadowTarget10").WorldPosition,
}

player = GetEntity("__player")

distanceToPlayer = 0
linked = false

function chooseRandomTargetIndex()
    -- choose a random target from the list
    return Random.IntMinMax(1, #targets + 1)
end

function getNextTargetIndex(currentTargetIndex)
    -- get the next target index
    return (currentTargetIndex % #targets) + 1
end

function getPreviousTargetIndex(currentTargetIndex)
    -- get the previous target index
    if currentTargetIndex == 1 then
        return #targets
    else
        return currentTargetIndex - 1
    end
end

function moveToTarget(index)
    -- move the object to the position of a target index
    this.GameObject.WorldPosition = targets[index]
end

movingBackwards = false
currentTarget = chooseRandomTargetIndex()
finishedRotating = false
completedMotion = false

function moveToWorldPosition(target, moveSpeed)
    -- move us towards a target position, returning if we're there yet
    local completed = this.MoveTowards(target, moveSpeed)
    return completed
end

function advanceCurrentTarget()
    -- set currentTarget to the next target in the sequence based on movingBackwards
    if movingBackwards then
        currentTarget = getPreviousTargetIndex(currentTarget)
    else
        currentTarget = getNextTargetIndex(currentTarget)
    end
end

function start()
    -- called when this entity is created
    if IsDayEven() then
        -- only appear on odd days
        this.GameObject.SetActive(false)
        return
    end

    if Random.OneIn(3) then
        -- one in 3 chance of not appearing
        this.GameObject.SetActive(false)
        return
    end
    
    if Random.OneIn(2) then
        -- one in 2 chance to move backwards
        movingBackwards = true
    end

    this.PlayAnimation(1) -- play walk animation

    -- move us to the first target, and advance to target the following target
    currentTarget = chooseRandomTargetIndex()
    moveToTarget(currentTarget)
    advanceCurrentTarget()

    -- use action runner to look at, move towards, then advance to next target in a loop
    this.Action.WaitUntil(Condition.WaitForSeconds(Random.FloatMinMax(0, 3)))
               .Then(function() finishedRotating = this.LookTowards(targets[currentTarget], 25) end)
               .Until(Condition.Custom(|| finishedRotating))
               .Then(function() completedMotion = moveToWorldPosition(targets[currentTarget], 0.5) end)
               .Until(Condition.Custom(|| completedMotion))
               .Then(|| advanceCurrentTarget())
               .ThenLoop()

end

function update()
    -- called every frame while this entity is active
    this.SnapToFloor(10) -- snap us to the floor

    if linked then return end -- don't run if we've linked

    -- link to another dream when player is close
    if distanceToPlayer < 0.3 and not linked then
        linked = true
        DreamSystem.SetNextTransitionDream(dreams.Concretorium)
        DreamSystem.TransitionToDream()
    end
end

function intervalUpdate()
    -- update distance on an interval as length() can be costly
    distanceToPlayer = (player.WorldPosition - this.GameObject.WorldPosition).length()
end

function interact()
    -- called depending on the interaction type of the object
    this.LogGraphContribution(-3, -3)
end
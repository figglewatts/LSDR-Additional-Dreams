require "dreams"

audio = this.GameObject.GetChildByName("Audio").DreamAudio
player = GetEntity("__player")
target1 = GetEntity(this.GameObject.Name .. "_Target1").WorldPosition
target2 = GetEntity(this.GameObject.Name .. "_Target2").WorldPosition

interacted = false
finishedRotating = false
distanceToPlayer = 0
linked = false

function start()
    -- called when this entity is created
    if Random.OneIn(2) then
        -- one in 2 chance of not appearing
        this.GameObject.SetActive(false)
        return
    end

    if not IsDayEven() then
        -- only appear on even days
        this.GameObject.SetActive(false)
        return
    end

    -- hide initially
    this.SetRenderersActive(false)
end

function update()
    -- called every frame while this entity is active
    if linked then return end -- if we've linked from this entity don't update

    -- link to another dream when player is close
    if distanceToPlayer < 0.3 and not linked then
        linked = true
        DreamSystem.SetNextTransitionDream(dreams.LeisureCentre)
        DreamSystem.TransitionToDream()
    end
end

function intervalUpdate()
    -- update distance on an interval as length() can be costly
    distanceToPlayer = (player.WorldPosition - this.GameObject.WorldPosition).length()
end

function interact()
    interacted = true -- we have now interacted

    -- show ourselves, start playing the sound, log on graph
    this.SetRenderersActive(true) 
    audio.Play()
    this.LogGraphContribution(3, 5)

    -- look towards and move towards the 2 targets in a loop
    this.Action.Do(function() finishedRotating = this.LookTowards(target2, 50) end)
               .Until(Condition.Custom(|| finishedRotating))
               .Then(|| this.MoveTowards(target2, 1))
               .Until(Condition.WaitForLinearMove(this.GameObject, target2))
               .Then(function() finishedRotating = this.LookTowards(target1, 50) end)
               .Until(Condition.Custom(|| finishedRotating))
               .Then(|| this.MoveTowards(target1, 1))
               .Until(Condition.WaitForLinearMove(this.GameObject, target1))
               .ThenLoop()
end
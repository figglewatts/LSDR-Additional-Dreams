require "dreams"

player = GetEntity("__player")

target = GetEntity("TyreTarget").WorldPosition
audio = this.GameObject.GetChildByName("Audio").DreamAudio

distanceToPlayer = 0
linked = false
completedMotion = false

function start()
    -- called when this entity is created
    if IsDayEven() then
        -- only appear on odd days
        this.GameObject.SetActive(false)
        return
    end
    
    if Random.OneIn(2) then
        -- 1 in 2 chance to not appear
        this.GameObject.SetActive(false)
        return
    end

    -- hide initially
    this.SetRenderersActive(false)
end

function update()
    -- called every frame while this entity is active
    this.SnapToFloor() -- snap us to the floor

    -- called every frame while this entity is active
    if linked then return end -- don't run if we've linked

    -- link to another dream when player is close
    if distanceToPlayer < 0.3 and not linked then
        linked = true
        DreamSystem.SetNextTransitionDream(dreams.School)
        DreamSystem.TransitionToDream()
    end
end

function intervalUpdate()
    -- update distance on an interval as length() can be costly
    distanceToPlayer = (player.WorldPosition - this.GameObject.WorldPosition).length()
end

function interact()
    -- called depending on the interaction type of the object
    this.SetRenderersActive(true) -- show ourselves
    audio.Play() -- play bounce sound
    this.LogGraphContribution(-3, 1)

    -- use action runner to move towards the target
    this.Action.Do(function() completedMotion = this.MoveTowards(target, 0.5) end)
               .Until(Condition.Custom(|| completedMotion))
               .ThenFinish()
end
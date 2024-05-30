require "dreams"

player = GetEntity("__player")
audio = this.GameObject.GetChildByName("Audio").DreamAudio

distanceToPlayer = 0
linked = false

function start()
    -- called when this entity is created

    if Random.OneIn(2) then
        -- one in 2 chance to appear
        this.GameObject.SetActive(false)
        return
    end

    if not IsDayEven() then
        -- only appear on even days
        this.GameObject.SetActive(false)
        return
    end

    -- randomize rotation
    this.GameObject.LocalRotation = Unity.Vector3(0, Random.FloatMinMax(0, 360), 0)
    
    -- hide initially
    this.SetRenderersActive(false)
end

function update()
    -- called every frame while this entity is active
    if linked then return end -- if we've linked from this entity don't update

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
    this.LogGraphContribution(2, 3)

    -- show basketball, start bouncing
    this.SetRenderersActive(true)
    this.PlayAnimation(0)

    -- wait until we hit the ground, play the bounce sound, then loop
    this.Action.WaitUntil(Condition.WaitForSeconds(0.833))
               .Then(|| audio.Play())
               .ThenLoop()
end
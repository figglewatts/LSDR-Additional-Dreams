require "dreams"

player = GetEntity("__player")

distanceToPlayer = 0
linked = false

function start()
    -- called when this entity is created
    if IsDayEven() then
        -- only show on odd days
        this.GameObject.SetActive(false)
        return
    end
    
    if Random.OneIn(2) then
        -- one in 2 chance of not being visible
        this.GameObject.SetActive(false)
        return
    end

    -- set our scale to within a random range
    local randScale = Random.FloatMinMax(0.4, 1.5)
    this.GameObject.Scale = Unity.Vector3(randScale, randScale, randScale)

    if Random.OneIn(10) then
        -- one in 10 chance of being big
        this.GameObject.Scale = Unity.Vector3(3, 3, 3)
    end

    -- randomise our rotation
    this.GameObject.LocalRotation = Unity.Vector3(0, Random.FloatMinMax(0, 360), 0)
end

function update()
    -- called every frame while this entity is active
    if linked then return end -- if we've linked from this entity don't update

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
    this.LogGraphContribution(2, -1)
end
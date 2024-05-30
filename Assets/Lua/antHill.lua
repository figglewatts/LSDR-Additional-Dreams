require "dreams"

player = GetEntity("__player")

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

    if Random.OneIn(4) then
        -- double scale
        this.GameObject.Scale = this.GameObject.Scale * 2
    end 

    if Random.OneIn(10) then
        -- quadruple scale
        this.GameObject.Scale = this.GameObject.Scale * 4
    end 
end

function update()
    -- called every frame while this entity is active
    if linked then return end -- if we've linked from this entity don't update

    -- link to another dream when player is close
    if distanceToPlayer < 0.3 and not linked then
        linked = true
        DreamSystem.SetNextTransitionDream(dreams.PowerStation)
        DreamSystem.TransitionToDream()
    end
end

function intervalUpdate()
    -- update distance on an interval as length() can be costly
    distanceToPlayer = (player.WorldPosition - this.GameObject.WorldPosition).length()
end

function interact()
    -- called depending on the interaction type of the object
end
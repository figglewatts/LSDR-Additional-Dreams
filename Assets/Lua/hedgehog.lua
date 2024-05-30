require "dreams"

player = GetEntity("__player")

distanceToPlayer = 0
linked = false

function start()
    -- called when this entity is created
    if Random.OneIn(2) then
        -- 1 in 2 chance to not appear
        this.GameObject.SetActive(false)
        return
    end

    if IsDayEven() then
        -- only appear on odd days
        this.GameObject.SetActive(false)
        return
    end

    if Random.OneIn(4) then
        -- 1 in 4 chance to have size doubled
        this.GameObject.Scale = Unity.Vector3(2, 2, 2)
    end 
end

function update()
    -- called every frame while this entity is active
    if linked then return end -- if we've linked from this entity don't update
    
    -- link to another dream when player is close
    if distanceToPlayer < 0.3 and not linked then
        linked = true
        DreamSystem.SetNextTransitionDream(dreams.TrashOut)
        DreamSystem.TransitionToDream()
    end
end

function intervalUpdate()
    -- update distance on an interval as length() can be costly
    distanceToPlayer = (player.WorldPosition - this.GameObject.WorldPosition).length()
end

function interact()
    -- called depending on the interaction type of the object
    this.LogGraphContribution(-2, -2)
end
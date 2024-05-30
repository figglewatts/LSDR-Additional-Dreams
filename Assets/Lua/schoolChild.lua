require "dreams"

player = GetEntity("__player")

distanceToPlayer = 0
linked = false

function start()
    -- called when this entity is created

    if Random.OneIn(4) then
        -- one in 4 chance of not showing
        this.GameObject.SetActive(false)
        return
    end

    if IsDayEven() then
        -- only show on odd days
        this.GameObject.SetActive(false)
        return
    end
end

function update()
    -- called every frame while this entity is active
    if linked then return end -- if we've linked, don't run

    -- if the player is close enough, link to another dream
    if distanceToPlayer < 0.3 and not linked then
        linked = true
        DreamSystem.SetNextTransitionDream(dreams.Forum)
        DreamSystem.TransitionToDream()
    end
end

function intervalUpdate()
    -- update distance on an interval as length() can be costly
    distanceToPlayer = (player.WorldPosition - this.GameObject.WorldPosition).length()
end

function interact()
    -- called depending on the interaction type of the object
    this.LogGraphContribution(-3, -1)
end
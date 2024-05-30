function start()
    -- called when this entity is created

    if Random.OneIn(2) then
        -- one in 2 chance of not appearing
        this.GameObject.SetActive(false)
        return
    end

    if IsDayEven() then
        -- only appear on odd days
        this.GameObject.SetActive(false)
        return
    end
end

function update()
    -- called every frame while this entity is active
end

function intervalUpdate()
    -- called on a configurable interval while this object is active
end

function interact()
    -- called depending on the interaction type of the object
    this.LogGraphContribution(0, -3)
end
interacted = false

function start()
    -- called when this entity is created

    if Random.OneIn(2) then
        -- 1 in 2 chance of not appearing
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
    if not interacted then return end -- don't run unless we've interacted
    
    -- move forwards
    this.MoveInDirection(this.Forward, 0.5)
end

function intervalUpdate()
    -- called on a configurable interval while this object is active
end

function interact()
    -- called depending on the interaction type of the object
    interacted = true
    this.SetRenderersActive(true) -- show ourselves
    this.LogGraphContribution(3, -3)
end
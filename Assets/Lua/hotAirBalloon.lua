interacted = false
rotation = 0

function start()
    -- called when this entity is created
    if not IsDayEven() then
        -- only appear on even days
        this.GameObject.SetActive(false)
        return
    end
    
    if Random.OneIn(2) then
        -- one in 2 chance of not appearing
        this.GameObject.SetActive(false)
        return
    end

    -- hide initially
    this.SetRenderersActive(false)
end

function update()
    -- called every frame while this entity is active
    if not interacted then return end -- dont run this until we've interacted

    -- rotate us around on Y
    rotation = rotation + 30 * Unity.DeltaTime()
    this.GameObject.LocalRotation = Unity.Vector3(0, rotation, 0)
    
    -- float upwards
    this.MoveInDirection(this.Up, 0.4)
end

function intervalUpdate()
    -- called on a configurable interval while this object is active
end

function interact()
    -- called depending on the interaction type of the object
    this.SetRenderersActive(true) -- show us
    this.LogGraphContribution(1, 3)
    interacted = true
end
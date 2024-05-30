audio = this.GameObject.GetChildByName("Audio").DreamAudio

interacted = false
moveSpeed = 0.75

function start()
    -- called when this entity is created
    if not IsDayEven() then
        -- only appear on even days
        this.GameObject.SetActive(false)
        return
    end

    -- hide initially
    this.SetChildVisible(false)
end

function update()
    -- called every frame while this entity is active
    if not interacted then return end -- don't update if we haven't yet interacted

    -- move forwards
    this.MoveInDirection(this.Forward, moveSpeed)
end

function intervalUpdate()
    -- called on a configurable interval while this object is active
end

function interact()
    -- called depending on the interaction type of the object
    -- show ourselves, play flying audio, and log graph
    interacted = true
    this.SetChildVisible(true)
    audio.Play()
    this.LogGraphContribution(-3, 1)
end
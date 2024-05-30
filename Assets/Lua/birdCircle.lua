audio = this.GameObject.GetChildByName("Audio").DreamAudio

interacted = false
moveSpeed = 0.75

function start()
    if not IsDayEven() then
        -- only appear on even days
        this.GameObject.SetActive(false)
        return
    end

    -- hide initially
    this.SetChildVisible(false)
end

function update()
    if not interacted then return end -- do nothing until we're in range

    -- look towards our right and fly forwards to circle
    this.LookTowards(this.GameObject.WorldPosition + this.GameObject.RightDirection, 10)
    this.MoveInDirection(this.GameObject.ForwardDirection, moveSpeed)
end

function interact()
    -- once we're in range, show ourselves, play flying sound, and log graph
    interacted = true
    this.SetChildVisible(true)
    audio.Play()
    this.LogGraphContribution(2, -7)
end
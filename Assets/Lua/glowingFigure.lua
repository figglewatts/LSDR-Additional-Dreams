NUM_TARGETS = 19

player = GetEntity("__player")
audio = this.GameObject.GetChildByName("Audio").DreamAudio

function spawnOnRandomTarget()
    -- choose a random target and move ourselves to it
    randTargetIndex = Random.IntMinMax(1, NUM_TARGETS + 1)
    this.GameObject.WorldPosition = GetEntity("GlowingFigure_Target" .. randTargetIndex).WorldPosition
end

function start()
    -- called when this entity is created

    if Random.OneIn(2) then
        -- 1 in 2 chance of not appearing
        this.GameObject.SetActive(false)
        return
    end

    if IsDayEven() then
        -- only appear on odd days
        this.GameObject.SetActive(false)
        return
    end

    spawnOnRandomTarget()
end

function update()
    -- called every frame while this entity is active
    -- look at the player
    this.LookAtPlane(player.WorldPosition)
end

function intervalUpdate()
    -- called on a configurable interval while this object is active
    -- check distance from player, if we get close enough then log graph and move to new target
    local playerDistance = (player.WorldPosition - this.GameObject.WorldPosition).length()
    if playerDistance < 3 then
        this.LogGraphContribution(3, 0)
        audio.Play()
        spawnOnRandomTarget()
    end
end

function interact()
    -- called depending on the interaction type of the object
end
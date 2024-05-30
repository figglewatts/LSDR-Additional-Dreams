audio = this.GameObject.GetChildByName("Audio").DreamAudio
popups = {
    this.GameObject.GetChildByName("popup1"),
    this.GameObject.GetChildByName("popup2"),
    this.GameObject.GetChildByName("popup3"),
    this.GameObject.GetChildByName("popup4")
}
player = GetEntity("__player")

currentPopup = nil
interacted = false

-- show a random popup
function showRandomPopup()
    if currentPopup != nil then
        -- set the current popup to inactive if there is one
        currentPopup.SetActive(false)
    end

    -- then choose a new popup, show it, and play the popup anim
    currentPopup = popups[Random.IntMinMax(1, #popups + 1)]
    currentPopup.SetActive(true)
    currentPopup.AnimatedObject.Play(0)
end

function start()
    -- called when this entity is created
    if not IsDayEven() then
        -- only show on even days
        this.GameObject.SetActive(false)
        return
    end

    -- hide initially
    this.SetRenderersActive(false)
end

function update()
    -- called every frame while this entity is active
    if not interacted then return end -- dont run until we've interacted

    -- look towards the player
    local toPlayer = this.GameObject.WorldPosition - player.WorldPosition
    toPlayer.y = 0
    this.LookInDirection(toPlayer)

    -- if we're too close, don't move towards player
    if toPlayer.length() < 1 then
        return
    end

    -- move towards player (negated due to model rotation)
    this.MoveInDirection(toPlayer.negated(), 0.3)
end

function intervalUpdate()
    -- called on a configurable interval while this object is active
end

function interact()
    -- called depending on the interaction type of the object
    interacted = true
    this.LogGraphContribution(2, 0)
    audio.Play() -- play popup audio

    -- use action runner to show a random popup on a timer
    this.Action.Do(|| showRandomPopup())
               .ThenWaitUntil(Condition.WaitForSeconds(3))
               .ThenLoop()
end
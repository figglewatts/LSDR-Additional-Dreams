-- used to ensure 'interior' dreams link to one another with a TriggerLua

interiorDreams = {
    GetDreamByName("Mill"),
    GetDreamByName("Belvoir"),
    GetDreamByName("Pooley"),
    GetDreamByName("Railway"),
    GetDreamByName("Eastern")
}

function linkToInteriorEntrance()
    -- choose a random interior dream to link to
    local interior = interiorDreams[Random.IntMinMax(1, #interiorDreams + 1)]

    -- set up the link like a tunnel entrance
    DreamSystem.SetNextTransitionDream(interior)
    DreamSystem.SetNextTransitionColor(Colors.Black)
    DreamSystem.SetTransitionSounds(false)
    DreamSystem.SetNextTransitionLockControls(true)
    DreamSystem.SetNextTransitionSpawnID("InteriorEntrance")
    DreamSystem.TransitionToDream() -- perform the link
end

function start()
    -- called when this entity is created
end

function update()
    -- called every frame while this entity is active
end

function onTrigger()
    -- called when the player enters the trigger
    linkToInteriorEntrance()
end

function onTriggerExit()
    -- called when the player exits the trigger
end
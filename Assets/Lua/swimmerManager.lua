swimmers = {
    GetEntity("SwimmerA"),
    GetEntity("SwimmerB"),
    GetEntity("SwimmerC"),
    GetEntity("SwimmerD"),
    GetEntity("SwimmerE"),
    GetEntity("SwimmerF")
}

fish = {
    GetEntity("FishA"),
    GetEntity("FishB"),
    GetEntity("FishC"),
    GetEntity("FishD"),
    GetEntity("FishE"),
    GetEntity("FishF")
}

isSwimmer = true

function setSwimmersActive(active)
    -- set all swimmer objects to given active state
    for i = 1, 6 do
        swimmers[i].SetActive(active)
    end
end

function setFishActive(active)
    -- set all fish objects to given active state
    for i = 1, 6 do
        fish[i].SetActive(active)
    end
end

function setActive(active)
    -- set objects active based on isSwimmer
    if isSwimmer then
        setSwimmersActive(active)
    else
        setFishActive(active)
    end
end

function raiseUp()
    -- raise up the objects, to make it look like they swim out of the water
    for i = 1, 6 do
        if isSwimmer then
            swimmerPos = swimmers[i].WorldPosition
            swimmers[i].WorldPosition = Unity.Vector3(swimmerPos.x, swimmerPos.y + 1.5, swimmerPos.z)
            
            -- now raise the movement targets
            target1 = GetEntity(swimmers[i].Name .. "_Target1")
            target1Pos = target1.WorldPosition
            target2 = GetEntity(swimmers[i].Name .. "_Target2")
            target2Pos = target2.WorldPosition
            target1.WorldPosition = Unity.Vector3(target1Pos.x, target1Pos.y + 1.5, target1Pos.z)
            target2.WorldPosition = Unity.Vector3(target2Pos.x, target2Pos.y + 1.5, target2Pos.z)
        else
            fishPos = fish[i].WorldPosition
            fish[i].WorldPosition = Unity.Vector3(fishPos.x, fishPos.y + 1.5, fishPos.z)
            
            -- now raise the movement targets
            target1 = GetEntity(fish[i].Name .. "_Target1")
            target1Pos = target1.WorldPosition
            target2 = GetEntity(fish[i].Name .. "_Target2")
            target2Pos = target2.WorldPosition
            target1.WorldPosition = Unity.Vector3(target1Pos.x, target1Pos.y + 1.5, target1Pos.z)
            target2.WorldPosition = Unity.Vector3(target2Pos.x, target2Pos.y + 1.5, target2Pos.z)
        end
    end
end

function start()
    -- set all objects inactive
    setSwimmersActive(false)
    setFishActive(false)

    if Random.OneIn(3) then
        -- one in three chance of none being active
        return
    end

    if IsDayEven() then
        -- fish!
        setFishActive(true)
        isSwimmer = false
    else
        setSwimmersActive(true)
        isSwimmer = true
    end

    if Random.OneIn(1) then
        -- one in 4 chance of being raised up
        raiseUp()
    end
end

function update()
end

function intervalUpdate()
    -- called on a configurable interval while this object is active
end

function interact()
end
dead = this.GameObject.GetChildByName("DeadShrub")
green = this.GameObject.GetChildByName("GreenShrub")
orange = this.GameObject.GetChildByName("OrangeShrub")
pink = this.GameObject.GetChildByName("PinkShrub")
plants = { green, orange, dead, pink }

function start()
    -- called when this entity is created
    if IsDayLinear(10, 1) then
        -- no shrub every 10th day
        return
    end

    -- choose a type based on the day number
    plantType = (DreamSystem.DayNumber - 1) % #plants
    usePlant(plantType)
end

function update()
    -- called every frame while this entity is active
end

function intervalUpdate()
    -- called on a configurable interval while this object is active
end

function interact()
    -- called depending on the interaction type of the object
end

function usePlant(plantType)
    plants[plantType + 1].SetActive(true)
end
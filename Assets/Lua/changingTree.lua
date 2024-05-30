dead = this.GameObject.GetChildByName("dead_tree")
green = this.GameObject.GetChildByName("green_tree")
orange = this.GameObject.GetChildByName("orange_tree")
pink = this.GameObject.GetChildByName("pink_tree")
trees = { green, orange, dead, pink }

function start()
    -- called when this entity is created
    if IsDayLinear(10, 1) then
        -- no tree every 10th day
        this.GameObject.SetActive(false)
        return
    end

    -- choose a tree based on the day number
    treeType = (DreamSystem.DayNumber - 1) % #trees
    useTree(treeType)
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

function useTree(treeType)
    trees[treeType + 1].SetActive(true)
end
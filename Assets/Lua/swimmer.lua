target1 = GetEntity(this.GameObject.Name .. "_Target1")
target2 = GetEntity(this.GameObject.Name .. "_Target2")

finishedRotating = false
finishedMoving = false

MOVE_SPEED = 1
ROTATE_SPEED = 32

function start()
    -- use action runner to look towards and move between both targets in a loop
    this.Action.Do(function() finishedRotating = this.LookTowards(target2.WorldPosition, ROTATE_SPEED) end)
               .Until(Condition.Custom(|| finishedRotating))
               .Then(function() finishedMoving = this.MoveTowards(target2.WorldPosition, MOVE_SPEED) end)
               .Until(Condition.Custom(|| finishedMoving))
               .Then(function() finishedRotating = this.LookTowards(target1.WorldPosition, ROTATE_SPEED) end)
               .Until(Condition.Custom(|| finishedRotating))
               .Then(function() finishedMoving = this.MoveTowards(target1.WorldPosition, MOVE_SPEED) end)
               .Until(Condition.Custom(|| finishedMoving))
               .ThenLoop()
end

function update()

end

function intervalUpdate()
    -- called on a configurable interval while this object is active
end

function interact()
    this.LogGraphContribution(3, 5)
end
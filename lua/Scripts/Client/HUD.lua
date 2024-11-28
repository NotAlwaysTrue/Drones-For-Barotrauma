Gamcam = Screen.Selected.Cam

GUI.Init()

Hook.Patch("Barotrauma.Character", "ControlLocalPlayer", function(character)
    if not character then return end
end, Hook.HookMethodType.After)
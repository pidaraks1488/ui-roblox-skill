local G2L = {};

-- StarterGui.cube-shadow
G2L["1"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));
G2L["1"]["Name"] = [[cube-shadow]];
G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;


-- StarterGui.cube-shadow.cube-frame-shadow
G2L["2"] = Instance.new("Frame", G2L["1"]);
G2L["2"]["BorderSizePixel"] = 0;
G2L["2"]["BackgroundColor3"] = Color3.fromRGB(49, 49, 49);
G2L["2"]["Size"] = UDim2.new(0, 38, 0, 38);
G2L["2"]["Position"] = UDim2.new(0.04471, 0, 0.38951, 0);
G2L["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["2"]["Name"] = [[cube-frame-shadow]];


-- StarterGui.cube-shadow.cube-frame-shadow.UIShadow
G2L["3"] = Instance.new("UIShadow", G2L["2"]);




return G2L["1"], require;

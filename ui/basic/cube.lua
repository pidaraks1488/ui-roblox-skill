local G2L = {};

-- StarterGui.cube
G2L["1"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));
G2L["1"]["Name"] = [[cube]];
G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;


-- StarterGui.cube.cube-frame
G2L["2"] = Instance.new("Frame", G2L["1"]);
G2L["2"]["BorderSizePixel"] = 0;
G2L["2"]["BackgroundColor3"] = Color3.fromRGB(49, 49, 49);
G2L["2"]["Size"] = UDim2.new(0, 38, 0, 38);
G2L["2"]["Position"] = UDim2.new(0.0095, 0, 0.38951, 0);
G2L["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["2"]["Name"] = [[cube-frame]];



return G2L["1"], require;

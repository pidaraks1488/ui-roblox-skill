local G2L = {};

-- StarterGui.barfull
G2L["1"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));
G2L["1"]["Name"] = [[barfull]];
G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;


-- StarterGui.barfull.bar-full
G2L["2"] = Instance.new("Frame", G2L["1"]);
G2L["2"]["BorderSizePixel"] = 0;
G2L["2"]["BackgroundColor3"] = Color3.fromRGB(68, 68, 68);
G2L["2"]["Size"] = UDim2.new(0, 172, 0, 8);
G2L["2"]["Position"] = UDim2.new(0.42573, 0, 0.603, 0);
G2L["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["2"]["Name"] = [[bar-full]];


-- StarterGui.barfull.bar-full.bar
G2L["3"] = Instance.new("Frame", G2L["2"]);
G2L["3"]["BorderSizePixel"] = 0;
G2L["3"]["BackgroundColor3"] = Color3.fromRGB(203, 203, 203);
G2L["3"]["Size"] = UDim2.new(0, 172, 0, 8);
G2L["3"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["3"]["Name"] = [[bar]];



return G2L["1"], require;

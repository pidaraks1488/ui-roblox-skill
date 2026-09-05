local G2L = {};

-- StarterGui.frame
G2L["1"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));
G2L["1"]["Name"] = [[frame]];
G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;


-- StarterGui.frame.simple-frame
G2L["2"] = Instance.new("Frame", G2L["1"]);
G2L["2"]["BorderSizePixel"] = 0;
G2L["2"]["BackgroundColor3"] = Color3.fromRGB(49, 49, 49);
G2L["2"]["Size"] = UDim2.new(0, 150, 0, 240);
G2L["2"]["Position"] = UDim2.new(0.0095, 0, 0.01498, 0);
G2L["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["2"]["Name"] = [[simple-frame]];



return G2L["1"], require;

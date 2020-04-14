vRPcufereC = {}
Tunnel.bindInterface("vRP_cufere",vRPcufereC)
Proxy.addInterface("vRP_cufere",vRPcufereC)
vRP = Proxy.getInterface("vRP")
vRPScufere = Tunnel.getInterface("vRP_cufere","vRP_cufere")

local fontId

Citizen.CreateThread(function()
	RegisterFontFile('lemonmilk')
	fontId = RegisterFontId('Lemon Milk')
end)

local draw = false
local keyarata = false
local arata = false
local cufarbasic = 5 
local cufarepic = 15
local cufarlegendar = 30

function isCursorInPosition(x,y,width,height)
	local sx, sy = GetActiveScreenResolution()
  local cx, cy = GetNuiCursorPosition ( )
  local cx, cy = (cx / sx), (cy / sy)
  
	local width = width / 2
	local height = height / 2
  
  if (cx >= (x - width) and cx <= (x + width)) and (cy >= (y - height) and cy <= (y + height)) then
	  return true
  else
	  return false
  end
end

function drawtxt(text,font,centre,x,y,scale,r,g,b,a)
    y = y - 0.010
    scale = scale/2
    y = y + 0.002
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextFont(fontId)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

function Draw3DText(x,y,z, text,scl) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(1)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString("~h~"..text)
        DrawText(_x,_y)
    end
end

RegisterNetEvent('aratachei')
AddEventHandler('aratachei',function(chei)
	while true do
		Citizen.Wait(0)
		if keyarata == true and draw == true then
			ShowCursorThisFrame()
			DisableControlAction(0,51,true)
			DisableControlAction(0,24,true)
		--[[DisableControlAction(0,136,true)
			DisableControlAction(0,133,true)
			DisableControlAction(0,134,true)
			DisableControlAction(0,139,true)]]
			DisableControlAction(0,47,true)
			DisableControlAction(0,58,true)
			DisableControlAction(0,263,true)
			DisableControlAction(0,264,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,140,true)
			DisableControlAction(0,141,true)
			DisableControlAction(0,142,true)
			DisableControlAction(0,143,true)
			DisableControlAction(0, 1, true)
			DisableControlAction(0, 2, true)
			DisableControlAction(0, 27, true)
			DisableControlAction(0, 172, true)
			DisableControlAction(0, 173, true)
			DisableControlAction(0, 174, true)
			DisableControlAction(0, 175, true)
			DisableControlAction(0, 176, true)
			DisableControlAction(0, 177, true)
			DrawRect(0.5,0.5,0.75,0.60, 25,25,25,225) --chenar
			-- caseta 1 --
			DrawRect(0.2+0.05,0.5-0.04,0.20,0.40, 255,255,255,80) --fundal alb
			DrawRect(0.2+0.05, 0.6+0.035, 0.20, 0.050, 0, 51, 0, 130) --buton
			-- caseta 2 --
			DrawRect(0.45+0.05,0.5-0.04,0.20,0.40, 255,255,255,80) --fundal alb
			DrawRect(0.45+0.05, 0.6+0.035, 0.20, 0.050, 0, 51, 0, 130) --buton
			-- caseta 3 --
			DrawRect(0.70+0.05,0.5-0.04,0.20,0.40, 255,255,255,80) --fundal alb
			DrawRect(0.70+0.05, 0.6+0.035, 0.20, 0.050, 0, 51, 0, 130) --buton
	
			DrawRect(0.45+0.05, 0.70+0.035, 0.22, 0.040, 255, 0, 0, 130) --buton2 rosu

			drawtxt("~o~[Chei]~w~ "..chei,1,1,0.21, 0.725,0.80,255,255,255,255)
			drawtxt("~o~[NUME SERVER]~w~ Cufere",1,1,0.5, 0.220,0.80,255,255,255,255)
			drawtxt("Pret:~o~"..cufarbasic,1,1,0.2+0.05, 0.250+0.035,0.65,255,255,255,255)
			drawtxt("Pret:~o~ "..cufarepic,1,1,0.45+0.05, 0.250+0.035,0.65,255,255,255,255)
			drawtxt("Pret:~o~ "..cufarlegendar,1,1,0.70+0.05, 0.250+0.035,0.65,255,255,255,255)
			--v2
			drawtxt("Cumpara",1,1,0.2+0.05, 0.6+0.035,0.45,255,255,255,255)
			drawtxt("Cumpara",1,1,0.45+0.05, 0.6+0.035,0.45,255,255,255,255)
			drawtxt("Cumpara",1,1,0.70+0.05, 0.6+0.035,0.45,255,255,255,255)
			--v2
			drawtxt("INCHIDE",1,1,0.45+0.05, 0.697+0.035,0.45,255,255,255,255)
			DrawSprite("legendarchest", "legendarchest", 0.70+0.05, 0.4+0.035, 0.13, 0.17, 0.0, 255, 255, 255, 255)
			DrawSprite("epichest", "epichest", 0.45+0.05, 0.4+0.035, 0.13, 0.17, 0.0, 255, 255, 255, 255)
			DrawSprite("basicchest", "basicchest", 0.2+0.05, 0.4+0.035, 0.13, 0.17, 0.0, 255, 255, 255, 255)
			if isCursorInPosition(0.2+0.05, 0.6+0.035, 0.20, 0.050) then
				SetCursorSprite(5)
				if(IsDisabledControlJustPressed(0, 24))then
					vRPScufere.cumparacufarbasic()
					keyarata = false
					draw = false
					arata = false
					break
				end
			elseif isCursorInPosition(0.45+0.05, 0.6+0.035, 0.20, 0.050) then
			SetCursorSprite(5)
			if(IsDisabledControlJustPressed(0, 24))then
				vRPScufere.cumparacufarepic()
				keyarata = false
				draw = false
				arata = false
				break
			end
			elseif isCursorInPosition(0.70+0.05, 0.6+0.035, 0.20, 0.050) then
				SetCursorSprite(5)
				if(IsDisabledControlJustPressed(0, 24))then
					vRPScufere.cumparacufarlegendar()
					keyarata = false
					draw = false
					arata = false
					break
				end
			elseif isCursorInPosition(0.45+0.05, 0.70+0.035, 0.22, 0.040) then
				SetCursorSprite(5)
				if(IsDisabledControlJustPressed(0, 24))then
					keyarata = false
					draw = false
					arata = false
					break
				end
			else
				SetCursorSprite(1)
			end
		else
			keyarata = false
			arata = false
			draw = false
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		local dist = Vdist(pos.x, pos.y, pos.z, -33.513404846191,-791.90155029297,44.225116729736)
		DrawMarker(2,-33.513404846191,-791.90155029297,44.225116729736,0, 0, 0, 0, 0, 0, 0.2501,0.2501,0.2501,121,121,121,140,1,0,0,true)
		if(Vdist(pos.x, pos.y, pos.z, -33.513404846191,-791.90155029297,44.225116729736) < 3.0) and arata == false then
			Draw3DText(pos.x, pos.y, pos.z+0.5, "~y~[ ~w~Apasa ~y~E ~w~pentru a deschide meniul ~y~]", 0.55)
			if(IsControlJustReleased(1, 51)) then
				draw = true
				keyarata = true
				arata = true
				if draw and keyarata then
					Citizen.Wait(1)
					vRPScufere.vezichei(source)
				end
			end
		end
	end
end)
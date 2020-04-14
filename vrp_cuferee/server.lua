local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_cufere")
vRPCcufere = Tunnel.getInterface("vRP_cufere","vRP_cufere")

vRPnc = Proxy.getInterface("vRP_newcoin")
MySQL = module("vrp_mysql", "MySQL")

vRPcufere = {}
Tunnel.bindInterface("vRP_cufere",vRPcufere)
Proxy.addInterface("vRP_cufere",vRPcufere)

MySQL.createCommand("vRP/chei_init_user","INSERT IGNORE INTO vrp_chei(user_id,chei) VALUES(@user_id,@chei)")
MySQL.createCommand("vRP/get_chei","SELECT * FROM vrp_chei WHERE user_id = @user_id")
MySQL.createCommand("vRP/set_chei","UPDATE vrp_chei SET chei = @chei WHERE user_id = @user_id")
MySQL.createCommand("vRP/get_halloween_vehicle","SELECT vehicle FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
MySQL.createCommand("vRP/bagamasina","INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,vehicle_plate,veh_type) VALUES(@user_id,@vehicle,@vehicle_plate,@veh_type)")

tmpchei = {}

function vRP.givePlayerSpecialVeh(user_id, vehName)
	vRP.getUserIdentity({user_id, function(identity)
		MySQL.query("vRP/bagamasina", {user_id = user_id, vehicle = vehName, vehicle_plate = "Syndkrex", veh_type = "car"})
	end})
end

function displaychei(value)
	return "<span class=\"symbol\">$</span> "..value
end

function vRPcufere.getchei(user_id)
	local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
	local chei = tonumber(tmpchei[user_id])
	if chei ~= nil then
		return tonumber(tmpchei[user_id])
	else
		return 0
	end
end

function vRPcufere.setchei(user_id,value)
	local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
	local chei = tonumber(tmpchei[user_id])
	if chei ~= nil then
		tmpchei[user_id] = tonumber(value)
	end

	local source = vRP.getUserSource({user_id})
	if source ~= nil then
		vRPclient.setDivContent(source,{"chei",displaychei(value)})
	end
end

function vRPcufere.givechei(user_id,amount)
	local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
	local chei = vRPcufere.getchei(user_id)
	local newchei = chei + amount
	vRPcufere.setchei(user_id,newchei)
end

function vRPcufere.takechei(user_id,amount)
	local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
	local chei = vRPcufere.getchei(user_id)
	local newchei = chei - amount
	print(newchei)
	vRPcufere.setchei(user_id,newchei)
end

function vRPcufere.trycheiPayment(user_id,amount)
	local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
	local chei = vRPcufere.getchei(user_id)
	if chei >= amount then
		vRPcufere.setchei(user_id,chei-amount)
		return true
	else
		return false
	end
end

AddEventHandler("vRP:playerJoin",function(user_id,source,name,last_login)
		local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
	local cfg = getcheiConfig()
	MySQL.execute("vRP/chei_init_user", {user_id = user_id, chei = cfg.open_chei}, function(affected)
		MySQL.query("vRP/get_chei", {user_id = user_id}, function(rows, affected)
			if #rows > 0 then
				tmpchei[user_id] = tonumber(rows[1].chei)
			end
		end)
	end)
end)

AddEventHandler("vRP:playerLeave",function(user_id,source)
		local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
	local chei = tmpchei[user_id]
	if chei and chei ~= nil then
		MySQL.execute("vRP/set_chei", {user_id = user_id, chei = chei})
	end
end)

AddEventHandler("vRP:save", function()
	for i, v in pairs(tmpchei) do
		if v ~= nil then
			MySQL.execute("vRP/set_chei", {user_id = i, chei = v})
		end
	end
end)

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
	if first_spawn then
		local cfg = getcheiConfig()
		local mychei = vRPcufere.getchei(user_id)
	end
end)

function vRPcufere.cumparacufarbasic()
	local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
	local sanse = math.random(1,1000)
	local bani = math.random(500,2500)
	local bitcoin = math.random(1,10)
	if vRPcufere.trycheiPayment(user_id,5) then
		vRPclient.notify(source,{"[NUME SERVER] Ai cumparat cufarul basic!"})
		if sanse <= 900 then
			vRP.giveMoney({user_id,bani})
			vRPclient.notify(source,{"[NUME SERVER] Ai castigat suma de "..bani.." !"})
		elseif sanse > 900 and sanse <= 930 then
			masina1(source)
		elseif sanse > 930 and sanse <= 1000 then
			vRPnc.giveCoins({user_id,bitcoin})
			vRPclient.notify(player,{"[NUME SERVER] Ai castigat "..bitcoin.." bitcoini!"})
		end
	else
		vRPclient.notify(source,{"[NUME SERVER] Nu ai destule chei!"})
	end
end

function vRPcufere.cumparacufarepic()
	local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
	local sanse = math.random(1,1000)
	local bani = math.random(10000,25000)
	local bitcoin = math.random(10,20)
	if vRPcufere.trycheiPayment(user_id,15) then
		vRPclient.notify(source,{"[NUME SERVER] Ai cumparat cufarul epic!"})
		if sanse >= 1 and sanse <= 10 then
			masina2(source)
			masina3(source)
		elseif sanse > 10 and sanse <= 350 then
			vRP.giveMoney({user_id,bani})
			vRPclient.notify(source,{"[NUME SERVER] Ai castigat suma de "..bani.." !"})
		elseif sanse > 350 and sanse <= 650 then
			vRP.giveInventoryItem({user_id,"kebab",50})
			vRP.giveInventoryItem({user_id,"milk",50})
			vRPclient.notify(source,{"[NUME SERVER] Ai castigat mancare pe viata!"})
		elseif sanse > 650 and sanse <= 750 then
			vRPcufere.givechei(user_id,30)
			vRPclient.notify(source,{"[NUME SERVER] Ai castigat 30 de chei!"})
		elseif sanse > 750 and sanse <= 790 then
			vRPcufere.givechei(user_id,50)
			vRPclient.notify(source,{"[NUME SERVER] Ai castigat 50 de chei!"})
		elseif sanse > 790 and sanse <= 1000 then
			vRPnc.giveCoins({user_id,bitcoin})
			vRPclient.notify(player,{"[NUME SERVER] Ai castigat "..bitcoin.." bitcoini!"})
		end
	else
		vRPclient.notify(source,{"[NUME SERVER] Nu ai destule chei!"})
	end
end

function vRPcufere.cumparacufarlegendar()
	local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
	local sanse = math.random(1,2500)
	local bani = math.random(25000,50000)
	local bitcoin = math.random(20,30)
	if vRPcufere.trycheiPayment(user_id,30) then
		vRPclient.notify(source,{"[NUME SERVER] Ai cumparat cufarul legendar!"})
		if sanse == 1 then
		vRPcufere.givechei(user_id,500)
		vRPclient.notify(source,{"[NUME SERVER] Ai castigat 500 de chei!"})
		elseif sanse >1 and sanse <=250 then
			masina1(source)
			masina2(source)
			masina3(source)
			vRP.giveMoney({user_id,bani})
			vRPclient.notify(source,{"[NUME SERVER] Ai castigat jackpotul suprem!"})
		elseif sanse > 250 and sanse <= 800 then
			vRP.giveMoney({user_id,bani})
			vRPclient.notify(source,{"[NUME SERVER] Ai castigat suma de "..bani.."!"})			
		elseif sanse > 800 and sanse <= 1000 then
			if vRP.hasGroup({user_id,"VIP GOLD"}) then
				vRPclient.notify(source,{"[NUME SERVER] Ai deja VIP GOLD \n Primesti cheile inapoi!"})	
				vRPcufere.givechei(user_id,30)
			else
			vRP.addUserGroup({user_id,"VIP GOLD"})
			vRPclient.notify(source,{"[NUME SERVER] Felicitari ai castigat VIP GOLD!"})
			end
		elseif sanse > 1000 and sanse <= 2000 then
			vRPnc.giveCoins({user_id,bitcoin})
			vRPclient.notify(player,{"[NUME SERVER] Ai castigat "..bitcoin.." bitcoini!"})
		elseif sanse > 2000 and sanse <= 2500 then
			vRPcufere.givechei(user_id,75)
			vRPclient.notify(source,{"[NUME SERVER] Ai castigat 75 de chei!"})
		end
		else
			vRPclient.notify(source,{"[NUME SERVER] Nu ai destule chei!"})
	end
end

function vRPcufere.vezichei()
	local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
	local chei = vRPcufere.getchei(user_id)
	TriggerClientEvent('aratachei',source,chei)
end

function masina1(player)
	local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
	if user_id ~= nil then
		vehName = "subwrx"
		MySQL.query("vRP/get_halloween_vehicle", {user_id = user_id, vehicle = vehName}, function(pvehicle, affected)
		if #pvehicle > 0 then
		vRPclient.notify(player, {"[NUME SERVER] Ai deja aceasta masina."})
		vRP.giveMoney({user_id,54000})
		vRP.closeMenu({player})
		return
		else
		vRP.givePlayerSpecialVeh({user_id, "subwrx"})		
		vRPclient.notify(player, {"[NUME SERVER] Ai castigat un SUBARU WRX!."})
			end
		end)
	end
end

function masina2(player)
	local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
	if user_id ~= nil then
		vehName = "x6m"
		MySQL.query("vRP/get_halloween_vehicle", {user_id = user_id, vehicle = vehName}, function(pvehicle, affected)
		if #pvehicle > 0 then
		vRPclient.notify(player, {"[NUME SERVER] Ai deja aceasta masina."})
		vRP.giveMoney({user_id,35000})
		vRP.closeMenu({player})
		return
		else
		vRP.givePlayerSpecialVeh({user_id, "x6m"})		
		vRPclient.notify(player, {"[NUME SERVER] Ai castigat un BMW X6M!."})
			end
		end)
	end
end

function masina3(player)
	local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
	if user_id ~= nil then
		vehName = "a8lfsi"
		MySQL.query("vRP/get_halloween_vehicle", {user_id = user_id, vehicle = vehName}, function(pvehicle, affected)
		if #pvehicle > 0 then
		vRPclient.notify(player, {"[NUME SERVER] Ai deja aceasta masina."})
		vRP.giveMoney({user_id,55000})
		vRP.closeMenu({player})
		return
		else
		vRP.givePlayerSpecialVeh({user_id, "a8lfsi"})		
		vRPclient.notify(player, {"[NUME SERVER] Ai castigat un AUDI A8L!."})
			end
		end)
	end
end

local function givePlayerCufere(player,choice)
	local id = vRP.getUserId({player})
	local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
	vRP.prompt({player, "User ID: ", "", function(player, user_id)
		user_id = tonumber(user_id)
		local target = vRP.getUserSource({user_id})
		if target ~= nil then
			vRP.prompt({player, "Chei: ", "", function(player, cufere)
				cufere = cufere
				if(tonumber(cufere))then
					cufere = tonumber(cufere)
					vRPcufere.givechei(user_id,cufere)
					vRPclient.notify(player, {"[Chei] I-ai oferit lui : "..GetPlayerName(target).." "..cufere.." chei"})
					vRPclient.notify(target, {"[Chei] "..GetPlayerName(player).." ti-a oferit "..cufere.." chei"})
					local webhook = "```"..GetPlayerName(player).." i-a dat lui "..GetPlayerName(target).." chei suma "..cufere.."```"
					PerformHttpRequest('https://discordapp.com/api/webhooks/681898299187527733/B1_KVH7epOYTrmgDPLJqlFQnu-uX_ywx6wvwJ7kGxpIuMu2EFad9h_BzseBYMtmEM6rP', function(err, text, headers) end, 'POST', json.encode({" ", content = webhook}), { ['Content-Type'] = 'application/json' })
				else
					vRPclient.notify(player, {"[Chei] Numarul trebuie sa fie un numar !"})
				end
			end})
		else
			vRPclient.notify(player, {"[Chei] Jucatorul nu este online!"})
		end
	end})
end

local function takePlayerCufere(player,choice)
	local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
	local id = vRP.getUserId({player})
	vRP.prompt({player, "User ID: ", "", function(player, user_id)
		user_id = tonumber(user_id)
		local target = vRP.getUserSource({user_id})
		if target ~= nil then
			vRP.prompt({player, "Chei: ", "", function(player, cufere)
				cufere = cufere
				local tCufere = tonumber(vRPcufere.getchei(user_id))
				if(tonumber(cufere))then
					cufere = tonumber(cufere)
					if(tCufere >= cufere)then
						vRPcufere.takechei(user_id,cufere)
						vRPclient.notify(player, {"[Chei] I-ai confiscat lui : "..GetPlayerName(target).." "..cufere.." chei"})
						vRPclient.notify(target, {"[Chei] "..GetPlayerName(player).." ti-a luat "..cufere.." chei"})
						local webhook = "```"..GetPlayerName(player).." i-a luat lui "..GetPlayerName(target).." chei suma "..cufere.."```"
						PerformHttpRequest('https://discordapp.com/api/webhooks/681898299187527733/B1_KVH7epOYTrmgDPLJqlFQnu-uX_ywx6wvwJ7kGxpIuMu2EFad9h_BzseBYMtmEM6rP', function(err, text, headers) end, 'POST', json.encode({" ", content = webhook}), { ['Content-Type'] = 'application/json' })
					else
						vRPclient.notify(player, {"[Chei] Jucatorul are doar "..tCufere.." chei"})
					end
				else
					vRPclient.notify(player, {"[Chei] Numarul trebuie sa fie un numar !"})
				end
			end})
		else
			vRPclient.notify(player, {"[Chei] Jucatorul nu este online!"})
		end
	end})
end

vRP.registerMenuBuilder({"admin", function(add, data)
			local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
	local user_id = vRP.getUserId({data.player})
	if user_id ~= nil then
		local choices = {}
		if(vRP.hasPermission({user_id, "newcoin.give"}))then
			choices["Ofera chei"] = {givePlayerCufere, "Ofera <font color= 'yellow'>Chei</font> unui jucator"}
		end
		if(vRP.hasPermission({user_id, "newcoin.give"}))then
			choices["Confisca chei"] = {takePlayerCufere, "Confisca <font color= 'yellow'>Chei</font> unui jucator"}
		end
		add(choices)
	end
end})

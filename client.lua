Citizen.CreateThread(function()
	RegisterCommand('trevive', function() -- Change trevive to a command you want
		if IsEntityDead(ped) then
		revivePed(ped)
		TriggerEvent('chatMessage', "Server", {200,0,0}, "You're Feeling A lot Better!")
		StopScreenEffect("DeathFailOut", 0,0)
		Citizen.Wait(0)
		end
	end)
end)

-- defines what the funtion revivePed(ped) does
function revivePed(ped)
	local playerPos = GetEntityCoords(PlayerPedId(), false) -- Getting Player Pos

	NetworkResurrectLocalPlayer(playerPos, false, true, false) -- Making
	SetPlayerInvincible(PlayerPedId(), false) -- Makes Sure Ped Isnt Invincible After Respawn
	ClearPedBloodDamage(PlayerPedId()) -- Get Rid Of All Blood
	SetEntityHealth(PlayerPedId(), 200) -- Makes Sure Ped Is Healed
end

-- /die To Make Yourself Die Along With A Ragdoll
Citizen.CreateThread(function()
	RegisterCommand('die', function() -- change die to whatever you want 
		SetEntityHealth(PlayerPedId(), 0) -- Kills The Ped
		TriggerEvent('chatMessage', "Server", {200,0,0}, "You Killed Yourself!")
		sound()
		effect()
		SetPedToRagdoll(PlayerPedId(), 50000, 50000, 0, 0, 0, 0) -- Makes The Ped Ragdoll Apon Death
		Citizen.Wait(0)
	end)
end)

-- Just A Way To Stop The DeathEffects
Citizen.CreateThread(function()
	RegisterCommand('stopeffect', function() 
		StopScreenEffect("DeathFailOut", 0,0)
	end)
end)

function sound()
	if Config.Sound.UseSound then
		PlaySoundFrontend(-1, "ScreenFlash", "WastedSounds", 1)
	end
end

function effect()
	if Config.Effect.UseEffect then
		StartScreenEffect("DeathFailOut", 0,0)
        ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)
		Citizen.Wait(10000)
		StopScreenEffect("DeathFailOut", 0,0)
	end 
end

-- Stops Auto Respawn
AddEventHandler('onClientMapStart', function()
	exports.spawnmanager:spawnPlayer() -- Makes Sure Player Spawn Alive
	Citizen.Wait(2500)
	exports.spawnmanager:setAutoSpawn(false)
end)
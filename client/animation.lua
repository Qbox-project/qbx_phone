local phoneProp = 0
local phoneModel = `prop_npc_phone_02`

local function CheckAnimLoop()
    CreateThread(function()
        while PhoneData.AnimationData.lib ~= nil and PhoneData.AnimationData.anim ~= nil do
            if not IsEntityPlayingAnim(cache.ped, PhoneData.AnimationData.lib, PhoneData.AnimationData.anim, 3) then
                lib.requestAnimDict(PhoneData.AnimationData.lib)
                TaskPlayAnim(cache.ped, PhoneData.AnimationData.lib, PhoneData.AnimationData.anim, 3.0, 3.0, -1, 50, 0, false, false, false)
            end
            Wait(500)
        end
    end)
end

function newPhoneProp()
	deletePhone()
	lib.requestModel(phoneModel)
	phoneProp = CreateObject(phoneModel, 1.0, 1.0, 1.0, true, true, false)

	local bone = GetPedBoneIndex(cache.ped, 28422)
	if phoneModel == `prop_cs_phone_01` then
		AttachEntityToEntity(phoneProp, cache.ped, bone, 0.0, 0.0, 0.0, 50.0, 320.0, 50.0, 1, 1, 0, 0, 2, 1)
	else
		AttachEntityToEntity(phoneProp, cache.ped, bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
	end
end

function deletePhone()
	if phoneProp ~= 0 then
		DeleteObject(phoneProp)
		phoneProp = 0
	end
end

function DoPhoneAnimation(anim)
    local AnimationLib = 'cellphone@'
    local AnimationStatus = anim
    if IsPedInAnyVehicle(cache.ped, false) then
        AnimationLib = 'anim@cellphone@in_car@ps'
    end
    lib.requestAnimDict(AnimationLib)
    TaskPlayAnim(cache.ped, AnimationLib, AnimationStatus, 3.0, 3.0, -1, 50, 0, false, false, false)
    PhoneData.AnimationData.lib = AnimationLib
    PhoneData.AnimationData.anim = AnimationStatus
    CheckAnimLoop()
end
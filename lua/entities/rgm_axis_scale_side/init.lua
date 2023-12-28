
include("shared.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

function ENT:ProcessMovement(offpos, offang, eyepos, eyeang, ent, bone, ppos, pnorm, movetype, _, startgrab, _, _, nphysscale)
	local intersect = self:GetGrabPos(eyepos, eyeang, ppos, pnorm)
	local pos, ang
	local pl = self:GetParent().Owner

	local localized, startmove, finalpos, boneang
	if ent:GetBoneParent(bone) ~= -1 then
		if pl.rgm.GizmoAng then
			boneang = pl.rgm.GizmoAng
		else
			local matrix = ent:GetBoneMatrix(ent:GetBoneParent(bone))
			boneang = matrix:GetAngles()
		end
	else
		if IsValid(ent) then
			boneang = ent:GetAngles()
		else
			boneang = angle_zero
		end
	end

	localized = LocalToWorld(offpos, angle_zero, intersect, self:GetAngles())
	localized = WorldToLocal(localized, angle_zero, self:GetPos(), boneang)

	finalpos = nphysscale + localized
	ang = ent:GetManipulateBoneAngles(bone)
	pos = finalpos

	return pos, ang
end

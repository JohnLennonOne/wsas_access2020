% beak   27 (1-9, 150-152, 279-293)
% crown  15 (294-308)
% eye    14 (136-149)
% belly  19 (198-212, 245-248)
% tail   40 (74-94, 168-182, 241-244)
% back   19 (59-73, 237-240)
% wing   24 (10-24, 213-217, 309-312)
% breast 19 (55-58, 106-120)
% leg    15 (264-278)

% beak     1-27  27
% crown   28-42  15
% eye     43-56  14
% belly   57-75  19
% tail    76-115 40
% back   116-134 19
% wing   135-158 24
% breast 159-177 19
% leg    178-192 15

function attrs = attr_all(attri)

beak_idx = [1:9, 150:152, 279:293];
crown_idx = 294:308;
eye_idx = 136:149;
belly_idx = [198:212, 245:248];
tail_idx = [74:94, 168:182, 241:244];
back_idx = [59:73, 237:240];
wing_idx = [10:24, 213:217, 309:312];
breast_idx = [55:58, 106:120];
leg_idx = 264:278;

attrs = zeros(1, 192);
attrs(1:27) = attri(beak_idx);
attrs(28:42) = attri(crown_idx);
attrs(43:56) = attri(eye_idx);
attrs(57:75) = attri(belly_idx);
attrs(76:115) = attri(tail_idx);
attrs(116:134) = attri(back_idx);
attrs(135:158) = attri(wing_idx);
attrs(159:177) = attri(breast_idx);
attrs(178:192) = attri(leg_idx);

end


function BR = sub_sigma(BN,RN)
    BR = ((1 - norm(RN)^2)*BN - (1 - norm(BN)^2)*RN + 2*cross(BN,RN))/(1 + norm(RN)^2*norm(BN)^2 + 2*dot(RN,BN));
end
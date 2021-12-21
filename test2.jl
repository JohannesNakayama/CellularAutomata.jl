using Random

rand_config = bitrand(20)

for i in rand_config
    print(Int(i))
    sleep(0.05)
end

sleep(1)


import random

def untemper(y):
    """Reverses the 'tempering' steps of the Mersenne Twister algorithm."""
    # Reverse y ^= (y >> 18)
    y ^= (y >> 18)
    # Reverse y ^= (y << 15) & 0xefc60000
    y ^= (y << 15) & 0xefc60000
    # Reverse y ^= (y << 7) & 0x9d2c5680
    temp = y
    for _ in range(4):
        temp = y ^ ((temp << 7) & 0x9d2c5680)
    y = temp
    # Reverse y ^= (y >> 11)
    temp = y
    for _ in range(2):
        temp = y ^ (temp >> 11)
    y = temp
    return y

def demonstrate_vulnerability():
    print("--- Phase 1: Observing 624 'random' outputs ---")
    # We collect 624 samples of 32-bit integers
    observed_outputs = [random.getrandbits(32) for _ in range(624)]
    
    print("--- Phase 2: Reconstructing Internal State ---")
    # Mersenne Twister state is an array of 624 integers
    reconstructed_state = tuple([untemper(x) for x in observed_outputs] + [624])
    
    # We create a NEW generator and force its state to match the one we 'cracked'
    attacker_bot = random.Random()
    # Python's state format: (version, state_tuple, gauss_next)
    attacker_bot.setstate((3, reconstructed_state, None))
    
    print("--- Phase 3: Predicting the Future ---")
    real_next_value = random.getrandbits(32)
    predicted_next_value = attacker_bot.getrandbits(32)
    
    print(f"Actual next random value:    {real_next_value}")
    print(f"Attacker's predicted value: {predicted_next_value}")
    
    if real_next_value == predicted_next_value:
        print("\nSUCCESS: The generator is compromised!")
    else:
        print("\nFAILURE: Prediction failed.")

if __name__ == "__main__":
    demonstrate_vulnerability()
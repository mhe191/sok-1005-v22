import numpy as np

def player_strategy(n_battalions,n_fields):
    #defining the array:
    battalions=np.zeros(n_fields,dtype=int)
    
    #assigning 25 battalions to the first four battle fields:
    battalions[0:3]=15
    battalions[3:4]=33
    battalions[4:]=11

    
    #asserting that all and no more than all battalions are used:
    battalions=battalions[np.random.rand(n_fields).argsort()]
    assert sum(battalions)==n_battalions
    
    return battalions


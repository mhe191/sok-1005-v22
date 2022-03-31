{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "07870d23-558e-4276-baae-c819bdcb9488",
   "metadata": {},
   "outputs": [],
   "source": [
    "import numpy as np\n",
    "\n",
    "def player_strategy(n_battalions,n_fields):\n",
    "    #defining the array:\n",
    "    battalions=np.zeros(n_fields,dtype=int)\n",
    "    \n",
    "    #assigning 25 battalions to the first four battle fields:\n",
    "    battalions[0:3]=15\n",
    "    battalions[3:4]=33\n",
    "    battalions[4:]=11\n",
    "\n",
    "    \n",
    "    #asserting that all and no more than all battalions are used:\n",
    "    battalions=battalions[np.random.rand(n_fields).argsort()]\n",
    "    assert sum(battalions)==n_battalions\n",
    "    \n",
    "    return battalions\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "3c38b339-fb7e-48a6-840e-79bbd9d293e6",
   "metadata": {},
   "outputs": [],
   "source": [
    "def computer_strategy(n_battalions,n_fields):\n",
    "    battalions=np.zeros(n_fields,dtype=int)\n",
    "    battalions[0:1]=8\n",
    "    battalions[1:4]=30\n",
    "    battalions[4:]=1\n",
    "    assert sum(battalions)==n_battalions\n",
    "    return battalions"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3 (ipykernel)",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.9.9"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}

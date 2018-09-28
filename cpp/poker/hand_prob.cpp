#include <iostream>
#include <fstream>
#include <string>

using namespace std;

#include "hand_prob.h"

const string CSV_PATH = "./data/hands.csv";
const string DEFAULT = "0.0";
const int MIN_PLAYERS = 2, MAX_PLAYERS = 10;

/*
    Returns the win probability given a poker hand and number of
    players. 
*/
float hand_probability(string target_hand, int num_players) {
    ifstream ip(CSV_PATH.c_str());

    string result_prob = DEFAULT;
    string hand, probabilities;

    if (!ip.is_open()) {
        cout << "ERROR: File path not found." << '\n';
    } else {
        do {
            getline(ip,hand,',');
            getline(ip,probabilities,'\n');
        } while (ip.good() && hand != target_hand);
    }

    if (hand == target_hand) {
        result_prob = get_probability(probabilities, num_players);
    } else {
        cout << "ERROR: Invalid poker hand." << '\n';
    }

    return atof(result_prob.c_str());
}

/*
    Splits probabilities' line extracted from csv file and
    returns the probability that corresponds the number 
    of players. 
*/
string get_probability(string probs, int num_players) {
    string target_probability;

    if (num_players >= MIN_PLAYERS && num_players <= MAX_PLAYERS) {
        int count = 0;

        while (count <= (num_players - 2)) {
            target_probability = probs.substr(0, probs.find(','));
            probs.erase(0, probs.find(',') + 1);
            count++;
        }
    } else {
        cout << "ERROR: Invalid number of players." << '\n';
    }

    return target_probability;
}

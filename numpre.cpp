#include <bits/stdc++.h>
using namespace std;
using ll = long long;
#define rep(j, i, n) for (ll i = j; i < (ll)(n); i++)
#define ff first
#define ss second
#define pii pair<int, int>
#define pll pair<ll, ll>

vector<vector<int>> number(9, vector<int>(9));
map<pii, vector<int>> canenter;
int cansolve = 0;

void enter(int i, int j) {
    // enter i,j
    // tate
    for (auto c : canenter[{i, j}]) {
        bool hantei = 0;
        rep(0, y, 9) {
            if (j == y) continue;
            for (auto d : canenter[{i, y}]) {
                if (number[i][y] != 0) continue;
                if (d == c) hantei = 1;
            }
        }
        if (!hantei) {
            number[i][j] = c;
            cansolve++;
            canenter[{i, j}].resize(0);
        }
    }

    // yoko
    for (auto c : canenter[{i, j}]) {
        bool hantei = 0;
        rep(0, t, 9) {
            if (i == t) continue;
            for (auto d : canenter[{t, j}]) {
                if (number[t][j] != 0) continue;
                if (d == c) hantei = 1;
            }
        }
        if (!hantei) {
            number[i][j] = c;
            cansolve++;
            canenter[{i, j}].resize(0);
        }
    }

    // square
    for (auto c : canenter[{i, j}]) {
        bool hantei = 0;

        int x = i / 3;
        int y = j / 3;
        rep(3 * x, ii, 3 * x + 3) {
            rep(3 * y, jj, 3 * y + 3) {
                if (i == ii && j == jj) continue;
                for (auto d : canenter[{ii, jj}]) {
                    if (number[ii][jj] != 0) continue;
                    if (d == c) hantei = 1;
                }
            }
        }
        if (!hantei) {
            number[i][j] = c;
            cansolve++;
            canenter[{i, j}].resize(0);
        }
    }
}

void all_groupe() {
    rep(0, i, 9) {
        rep(0, j, 9) {
            if (number[i][j] != 0) {
                canenter[{i, j}].resize(0);
                continue;
            }
            // canenter wo umeru
            canenter[{i, j}].resize(0);
            vector<bool> che(9, 0);
            rep(0, y, 9) {
                if (number[i][y] == 0) continue;
                che[number[i][y] - 1] = 1;
            }
            rep(0, t, 9) {
                if (number[t][j] == 0) continue;
                che[number[t][j] - 1] = 1;
            }
            int x = i / 3;
            int y = j / 3;
            rep(3 * x, ii, 3 * x + 3) {
                rep(3 * y, jj, 3 * y + 3) {
                    if (number[ii][jj] == 0) continue;
                    che[number[ii][jj] - 1] = 1;
                }
            }
            rep(0, k, 9) {
                if (!che[k]) {
                    canenter[{i, j}].push_back(k + 1);
                }
            }
        }
    }
}

int main() {
    rep(0, i, 9) {
        string s;
        cin >> s;
        rep(0, j, 9) { number[i][j] = s[j] - '0'; }
    }
    cout << endl;
    while (1) {
        cansolve = 0;
        all_groupe();
        rep(0, i, 9) {
            rep(0, j, 9) {
                if (canenter[{i, j}].size() == 1) {
                    cansolve++;
                    number[i][j] = canenter[{i, j}][0];
                    all_groupe();
                }
                if (number[i][j] != 0) continue;
                enter(i, j);
                all_groupe();
            }
        }
        if (cansolve == 0) break;
    }
    rep(0, i, 9) {
        rep(0, j, 9) cout << number[i][j];
        cout << endl;
    }
}
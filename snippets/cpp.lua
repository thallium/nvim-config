return {
    s("all", fmt("begin({}), end({})", { i(1), rep(1) })),
    s('dir', t('const vector<pair<int, int>> dir{{1, 0}, {-1, 0}, {0, 1}, {0, -1}};')),
    s('dir8', t('const vector<pair<int, int>> dir{{1, 0}, {-1, 0}, {0, 1}, {0, -1}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}};'))
}

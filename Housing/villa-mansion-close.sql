select v.Name as villaName, v.coordns as vCoordns, v.coordew AS vCoordew, v.hascottages
    , m.Name as mansionName, m.coordns, m.coordew
    , abs(v.coordns - m.coordns) AS yDist
    , abs(v.coordew - m.coordew) AS xDist
from villa AS v
    inner join mansion AS m
        ON abs(v.coordns - m.coordns) < 5
            AND abs(v.coordew - m.coordew) < 5
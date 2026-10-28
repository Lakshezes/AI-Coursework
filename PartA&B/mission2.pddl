(define (problem lunar-mission-2)
    (:domain lunar)

    ; 2 rovers, 2 landers 6 waypoints
    (:objects
        rover1 rover2 - rover 
        lander1 lander2 - lander 
        wp1 wp2 wp3 wp4 wp5 wp6 - waypoint
    )
    ; initial states
        ;rover1(associated with lander1) deployed at wp2 alongside lander at wp2
        ;rover2(associated with lander2) undeployed choose wp for lander2 (wp1) 
        ; connection between waypoints 
    (:init
        (belongsTo rover1 lander1)
        (belongsTo rover2 lander2)

        (roverAt rover1 wp2)
        (landerAt lander1 wp2)

        (undeployed rover2 lander2)
        (landerAt lander2 wp1) ;landing site wp1

        (noDataHeld rover1)
        (noSampleHeld rover1)

        (noDataHeld rover2)
        (noSampleHeld rover2)

        (landerSpaceFree lander1)
        (landerSpaceFree lander2)

        ;connection between waypoints
        (connected wp1 wp2)
        (connected wp2 wp1)

        (connected wp2 wp3)
        (connected wp2 wp4)
        (connected wp4 wp2)

        (connected wp3 wp5)
        (connected wp5 wp3)
        (connected wp5 wp6)

        (connected wp6 wp4)

    )
    ;save image at wp3 to l1
    ;save scan at wp4 to l2
    ;save image at wp2 to l2
    ;save scan at wp6 to l1
    ;collect sample from wp5 and store in l1
    ;collect sample wp1 to store in l2 
    (:goal
        (and
            (imageDelivered rover1 wp3 lander1)
            (scanDelivered rover1 wp6 lander1)

            (imageDelivered rover2 wp2 lander2)
            (scanDelivered rover2 wp4 lander2)

            (sampleDelivered rover1 wp5 lander1)
            (sampleDelivered rover2 wp1 lander2)

        )
    )
)


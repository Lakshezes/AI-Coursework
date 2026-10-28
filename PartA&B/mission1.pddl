(define (problem lunar-mission-1)
    (:domain lunar)

    
    (:objects
        rover1 - rover
        lander1 - lander
        wp1 wp2 wp3 wp4 wp5 - waypoint

    )
    ; initial states
        ; rover starts in lander undeployed
        ; choose landing site for lander wp1
        ; rover data (image,scan) and sample slots are intially empty 
        ; lander intially has room for 1 sample
        ; also have directed connections (e.g. wp1 -> wp2; wp2 -> wp3)
    (:init
        (belongsTo rover1 lander1)
        (undeployed rover1 lander1)

        (landerAt lander1 wp1)


        (noDataHeld rover1)
        (noSampleHeld rover1)

        (landerSpaceFree lander1)

        ;initialised connections
        (connected wp1 wp2)
        (connected wp1 wp4)
        (connected wp2 wp3)
        (connected wp3 wp5)
        (connected wp4 wp3)
        (connected wp5 wp1)

    )

    ;save an image at waypoint 5 to lander 1 
    ; save a scan at waypoint 3 to lander 1 
    ;collect a sample from waypoint 1 and store it in lander 1
    (:goal
        (and
            (imageDelivered rover1 wp5 lander1)

            (scanDelivered rover1 wp3 lander1)

            (sampleDelivered rover1 wp1 lander1)
        )
    )
)
(define (domain lunar)
    (:requirements :strips :typing)

    ; -------------------------------
    ; Types
    ; -------------------------------

    ; EXAMPLE

    ; (:types
    ;     parent_type
    ;     child_type - parent_type

    ; )
    (:types
        rover lander waypoint
        ;rover: vehicle that moves and performs task
        ;lander: delivers rover to the moon
        ;waypoint: location the rover needs to go to  
    )

    ; -------------------------------
    ; Predicates
    ; -------------------------------

    ; EXAMPLE

    ; (:predicates
    ;     (no_arity_predicate)
    ;     (one_arity_predicate ?p - parameter_type)
    ; )

    (:predicates
        (roverAt ?r - rover ?w - waypoint)  ;current waypoint of rover
        (landerAt ?l - lander ?w - waypoint) ;current waypoint of lander
        (connected ?from - waypoint ?to - waypoint) ;travel from point x to point y 
        (carryingSample ?r - rover ?w - waypoint)  ;carrying sample collected from point x
        (belongsTo ?r - rover ?l - lander) ; assignment of rover to lander 
        (undeployed ?r - rover ?l - lander) ; still sitting in the lander 
        (noDataHeld ?r - rover) ; currently holding no scan or image 
        (hasImage ?r - rover ?w - waypoint) ; rover has unsent image from a waypoint source
        (hasScan ?r - rover ?w - waypoint) ; rover has unsent scan from waypoint source 
        (imageDelivered ?r - rover ?w - waypoint ?l - lander) ; rover delivers image from waypoint to lander
        (scanDelivered ?r - rover ?w - waypoint ?l - lander); same thing for scan 
        (noSampleHeld ?r - rover) ; no sample held 
        (landerSpaceFree ?l - lander) ; lander having space for sample 
        (sampleDelivered ?r - rover ?w - waypoint ?l - lander) ; rover drops sample from waypoint to its respective lander 
    )

    ; -------------------------------
    ; Actions
    ; -------------------------------

    ; EXAMPLE

    ; (:action action-template
    ;     :parameters (?p - parameter_type)
    ;     :precondition (and
    ;         (one_arity_predicate ?p)
    ;     )
    ;     :effect 
    ;     (and 
    ;         (no_arity_predicate)
    ;         (not (one_arity_predicate ?p))
    ;     )
    ; )

    (:action deploy
        :parameters (?r - rover ?l - lander ?w - waypoint)
        :precondition (and
            (belongsTo ?r ?l) ; rover must be assigned to this lander
            (undeployed ?r ?l) ; the rover must still be in the lander
            (landerAt ?l ?w) ; deployment of rover starts when the lander has landed at a waypoint
        )
        :effect (and
            (not (undeployed ?r ?l)) ; the rover is not on the lander anymore
            (roverAt ?r ?w) ; set the rovers waypoint to the lander

        )
    )

    (:action captureImage 
        :parameters (?r - rover ?w - waypoint)
        :precondition (and 
            (roverAt ?r ?w)
            (noDataHeld ?r) ; rover must not be holding image or scan beforehand
        )
        :effect (and 
            (not (noDataHeld ?r)) ; memory of rover is now full carrying image
            (hasImage ?r ?w) ; rover now carries image taken at waypoint 
        )
    )

    (:action deliverImage
        :parameters (?r - rover ?w - waypoint ?l - lander)
        :precondition (and 
            (belongsTo ?r ?l)
            (hasImage ?r ?w)
        )
        :effect (and 
            (not (hasImage ?r ?w))
            (imageDelivered ?r ?w ?l)
            (noDataHeld ?r)
        )
    )

    (:action performScan
        :parameters (?r - rover ?w - waypoint)
        :precondition (and
            (roverAt ?r ?w)
            (noDataHeld ?r)
        )
        :effect (and 
            (not (noDataHeld ?r))
            (hasScan ?r ?w)
        )

    )

    (:action deliverScan
        :parameters (?r - rover ?w - waypoint ?l - lander)
        :precondition (and
            (belongsTo ?r ?l)
            (hasScan ?r ?w)
        )
        :effect (and
            (not (hasScan ?r ?w))
            (scanDelivered ?r ?w ?l)
            (noDataHeld ?r)
        )
    )

    (:action move
        :parameters (?r - rover ?from ?to - waypoint)
        :precondition (and
            (roverAt ?r ?from)
            (connected ?from ?to)
        )
        :effect (and 
            (not (roverAt ?r ?from))
            (roverAt ?r ?to)
        )
    )
    

    (:action collectSample
        :parameters (?r - rover ?w - waypoint)
        :precondition (and
            (roverAt ?r ?w)
            (noSampleHeld ?r)
        )
        :effect (and
            (not (noSampleHeld ?r))
            (carryingSample ?r ?w)
        )
    )

    (:action deliverSample
        :parameters (?r - rover?l - lander ?w ?base - waypoint)
        :precondition (and
            (belongsTo ?r ?l)
            (carryingSample ?r ?w)
            (roverAt ?r ?base)
            (landerAt ?l ?base)
            (landerSpaceFree ?l)
        )
        :effect (and
            (not (carryingSample ?r ?w))
            (sampleDelivered ?r ?w ?l)
            (noSampleHeld ?r)
            (not (landerSpaceFree ?l))
        )
    )
        

)



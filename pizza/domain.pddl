(define
    (domain order-pizza)
    (:requirements :strips :typing)
    (:types )
    (:constants )
    (:predicates
        (have_order)
        (maybe-have_order)
        (order_available)
        (have_location)
        (maybe-have_location)
        (have_payment_method)
        (maybe-have_payment_method)
        (have_card_number)
        (maybe-have_card_number)
        (goal)
        (can-do_ask-location)
        (can-do_ask-order)
        (can-do_ask-payment)
        (can-do_ask-card-number)
        (can-do_check-order-availability)
        (can-do_place-order)
        (can-do_clarify__ask-location)
        (can-do_clarify__ask-order)
        (can-do_clarify__ask-payment)
    )
    (:action ask-location
        :parameters()
        :precondition
            (and
                (not (have_location))
                (not (maybe-have_location))
                (can-do_ask-location)
            )
        :effect
            (labeled-oneof validate-response
                (outcome valid
                    (and
                        (have_location)
                        (not (maybe-have_location))
                    )
                )
                (outcome unclear
                    (and
                        (not (have_location))
                        (maybe-have_location)
                    )
                )
            )
    )
    (:action ask-order
        :parameters()
        :precondition
            (and
                (not (have_order))
                (not (maybe-have_order))
                (can-do_ask-order)
            )
        :effect
            (labeled-oneof validate-response
                (outcome valid
                    (and
                        (have_order)
                        (not (maybe-have_order))
                    )
                )
                (outcome unclear
                    (and
                        (not (have_order))
                        (maybe-have_order)
                    )
                )
            )
    )
    (:action ask-payment
        :parameters()
        :precondition
            (and
                (have_order)
                (not (maybe-have_order))
                (have_location)
                (not (maybe-have_location))
                (not (have_payment_method))
                (not (maybe-have_payment_method))
                (can-do_ask-payment)
            )
        :effect
            (labeled-oneof validate-response
                (outcome valid
                    (and
                        (have_payment_method)
                        (not (maybe-have_payment_method))
                    )
                )
                (outcome unclear
                    (and
                        (not (have_payment_method))
                        (maybe-have_payment_method)
                    )
                )
            )
    )
    (:action ask-card-number
        :parameters()
        :precondition
            (and
                (have_payment_method)
                (not (maybe-have_payment_method))
                (can-do_ask-card-number)
            )
        :effect
            (labeled-oneof validate-response
                (outcome valid
                    (and
                        (have_card_number)
                        (not (maybe-have_card_number))
                    )
                )
                (outcome unclear
                    (and
                        (not (have_card_number))
                        (maybe-have_card_number)
                    )
                )
            )
    )
    (:action check-order-availability
        :parameters()
        :precondition
            (and
                (have_order)
                (not (maybe-have_order))
                (can-do_check-order-availability)
            )
        :effect
            (labeled-oneof make-call
                (outcome in-stock
                    (and
                        (order_available)
                    )
                )
                (outcome out-of-stock
                    (and
                        (not (have_order))
                        (not (maybe-have_order))
                    )
                )
                (outcome site-down
                    (and
                    )
                )
            )
    )
    (:action place-order
        :parameters()
        :precondition
            (and
                (have_order)
                (not (maybe-have_order))
                (have_card_number)
                (not (maybe-have_card_number))
                (order_available)
                (can-do_place-order)
            )
        :effect
            (labeled-oneof make-call
                (outcome success
                    (and
                        (goal)
                        (not (can-do_ask-location))
                        (not (can-do_ask-order))
                        (not (can-do_ask-payment))
                        (not (can-do_ask-card-number))
                        (not (can-do_check-order-availability))
                    )
                )
                (outcome site-down
                    (and
                    )
                )
            )
    )
    (:action clarify__ask-location
        :parameters()
        :precondition
            (and
                (not (have_location))
                (maybe-have_location)
                (can-do_clarify__ask-location)
            )
        :effect
            (labeled-oneof yes-no
                (outcome confirm
                    (and
                        (have_location)
                        (not (maybe-have_location))
                    )
                )
                (outcome deny
                    (and
                        (not (have_location))
                        (not (maybe-have_location))
                    )
                )
            )
    )
    (:action clarify__ask-order
        :parameters()
        :precondition
            (and
                (not (have_order))
                (maybe-have_order)
                (can-do_clarify__ask-order)
            )
        :effect
            (labeled-oneof yes-no
                (outcome confirm
                    (and
                        (have_order)
                        (not (maybe-have_order))
                    )
                )
                (outcome deny
                    (and
                        (not (have_order))
                        (not (maybe-have_order))
                    )
                )
            )
    )
    (:action clarify__ask-payment
        :parameters()
        :precondition
            (and
                (not (have_payment_method))
                (maybe-have_payment_method)
                (can-do_clarify__ask-payment)
            )
        :effect
            (labeled-oneof yes-no
                (outcome confirm
                    (and
                        (have_payment_method)
                        (not (maybe-have_payment_method))
                    )
                )
                (outcome deny
                    (and
                        (not (have_payment_method))
                        (not (maybe-have_payment_method))
                    )
                )
            )
    )
)
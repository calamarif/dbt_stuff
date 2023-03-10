with 

source as (
    select * from {{ source ('dbt_stripe', 'payment') }}

),

payments as (

    select
        id as payment_id,
        orderid as order_id,
        paymentmethod as payment_method,
        status,
        -- amount is in cents, convert to dollars
        amount /100 as amount,
        created as created_at
        
    from source

)

select * from payments
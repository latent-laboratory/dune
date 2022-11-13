with sales as (
    select 
        block_time,
        platform,
        token_id / 1000000 as project_id,
        token_id,
        price_currency,
        currency,
        price_usd
    from (
        select block_time, 
               platform, 
               number_of_items, 
               nft_token_ids_array[1]::integer as token_id,
               original_amount as price_currency, 
               original_currency as currency, 
               usd_amount as price_usd 
        from nft.trades
        where nft_contract_address = '\xa7d8d9ef8d8ce8992df33d8b8cf4aebabd5bd270' or nft_contract_address = '\x059edd72cd353df5106d2b9cc5ab83a52287ac3a'
    )_
    where number_of_items = 1
)

select * from sales
where project_id = {{Project}} and block_time > now() - interval '{{Past}}'
order by block_time desc
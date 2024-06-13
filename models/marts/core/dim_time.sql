with
    hours as (select seq4() as hour from table(generator(rowcount => 24))),
    minutes as (select seq4() as minute from table(generator(rowcount => 60))),
    seconds as (select seq4() as second from table(generator(rowcount => 60))),
    time_combinations as (
        select
            h.hour,
            m.minute,
            s.second,
            time_from_parts(h.hour, m.minute, s.second) as time_of_day
        from hours h
        cross join minutes m
        cross join seconds s
    )

select
    hour,
    minute,
    second,
    time_of_day,
    hour * 3600 + minute * 60 + second as seconds_since_midnight,
    hour * 60 + minute as minutes_since_midnight
from time_combinations
order by hour, minute, second

[씨네 21] 

-- 1. 누적 관객수 순서대로 가져오시오.
select * from MOVIE
order by AUDIENCE_COUNT asc;

-- 2. '권상우' 배우가 출연한 영화를 가져오시오.
select m.TITLE_KOR
from MOVIE m
    inner join APPEAR a on m.MOVIE_SEQ = a.MOVIE_SEQ
        inner join ACTOR ac on ac.ACTOR_SEQ = a.ACTOR_SEQ
where ac.NAME ='권상우';

-- 3. '진성문' 감독이 제작한 영화를 가져오시오.
select m.TITLE_KOR
from MOVIE m
    inner join DIRECTION d on m.MOVIE_SEQ = d.MOVIE_SEQ
        inner join DIRECTOR dr on d.DIRECTOR_SEQ = dr.DIRECTOR_SEQ
where dr.NAME = '진성문';

-- 4. 씨네 21 평점 6.0 이상 + 네티즌 평점 6.0 이상  받은 영화를 가져오시오.
select distinct m.TITLE_KOR
from MOVIE m
    inner join USERREVIEW ur on m.MOVIE_SEQ = ur.MOVIE_SEQ
        inner join MOVIE_USER u on u.MOVIE_USER_SEQ = ur.USER_SEQ
group by m.TITLE_KOR
    having avg(ur.rating) >= 6.0
INTERSECT
select distinct m.TITLE_KOR
from MOVIE m
    inner join EXPERTREVIEW er on m.MOVIE_SEQ = er.MOVIE_SEQ
        inner join MOVIE_EXPERT e on e.MOVIE_EXPERT_SEQ = er.EXPERT_SEQ
group by m.TITLE_KOR
    having avg(er.RATING) >= 6.0;


-- 5. 등록된 영화 중 가장 많은 영화에 참여한 배우와 영화를 가져오시오.
select ac.name, m.TITLE_KOR
from MOVIE m
    inner join APPEAR a on m.MOVIE_SEQ = a.MOVIE_SEQ
        inner join ACTOR ac on ac.ACTOR_SEQ = a.ACTOR_SEQ
where ac.name = (select ac.name
                from APPEAR a
                inner join ACTOR ac on ac.ACTOR_SEQ = a.ACTOR_SEQ
                group by ac.name
                    having count(ac.name)=(select max(count(*))
                                            from APPEAR
                                           group by ACTOR_SEQ));

-- 6. 장르 중 '드라마'와 '액션'을 동시에 속한 영화를 가져오시오.
select m.TITLE_KOR
from MOVIE m
    inner join MOVIE_GENRE mg on m.MOVIE_SEQ = mg.MOVIE_SEQ
        inner join GENRE g on g.GENRE_SEQ = mg.GENRE_SEQ
where g.GENRE_NAME ='드라마' and g.GENRE_NAME ='액션';

-- 7. 상영시간이 120분 미만인 영화를 가져오시오.
select TITLE_KOR
from MOVIE
where time < 120;

-- 8. 15세 이상 관람가 영화를 가져오시오.
select TITLE_KOR
from MOVIE
where  RATING_SEQ = (select rating_seq
                    from MOVIE_RATING
                    where RATING_NAME = '15세이상관람가')

-- 9. 네티즌 리뷰가 가장 많이 달린 순으로 가져오시오.
select m.TITLE_KOR,count(u.movie_seq)
from MOVIE m
    inner join USERREVIEW u on m.MOVIE_SEQ = u. MOVIE_SEQ
group by m.MOVIE_SEQ, m.TITLE_KOR
order by count(u.MOVIE_SEQ) desc;

-- 10. 네티블 리뷰를 가장 많이 작성한 네티즌의 아이디를 가져오시오.
select u.NAME
from USERREVIEW ur
    inner join MOVIE_USER u on u.MOVIE_USER_SEQ = ur.USER_SEQ
group by u.name
having count(ur.USER_SEQ) = (select max(count(user_seq))
                            from USERREVIEW
                            group by user_seq);


-- 11. 전문가 별점에 가장 많이 참여한 전문가의 이름을 가져오시오.
select e.name
from EXPERTREVIEW er
    inner join MOVIE_EXPERT e on e.MOVIE_EXPERT_SEQ = er.EXPERT_SEQ
group by e.name
having count(er.EXPERT_SEQ) = (select max(count(EXPERT_SEQ)) from EXPERTREVIEW group by EXPERT_SEQ);




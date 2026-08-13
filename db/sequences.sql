CREATE SEQUENCE stock_no_seq START WITH 1;
CREATE SEQUENCE coupon_no_seq START WITH 1;
CREATE SEQUENCE coupon_purchase_no_seq START WITH 1;
CREATE SEQUENCE news_no_seq START WITH 1;
CREATE SEQUENCE get_point_no_seq START WITH 1;
CREATE SEQUENCE order_no_seq START WITH 1;
CREATE SEQUENCE transaction_no_seq START WITH 1;

drop sequence stock_no_seq;
drop sequence coupon_no_seq;
drop sequence coupon_purchase_no_seq;
drop sequence get_point_no_seq;

drop sequence order_no_seq;
drop sequence transaction_no_seq;
drop sequence news_no_seq;

commit;
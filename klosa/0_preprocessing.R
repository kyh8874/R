library(tidyverse)
library(foreign)

read.dta("data/Lt01.dta",convert.factors = FALSE) %>%    
    select(pid,w01_fam1,w01edu,w01gender1,w01A002y,
           w01A002_age,w01marital,w01ecoact_s,w01A030,w01A032,
           w01region1,w01fromchildren,w01tochildren,w01fromparent,
           w01toparent,w01fromothers,w01toothers,w01transferfrom,
           w01transferto,w01chronic_sum,w01chronic_a,w01chronic_b,
           w01chronic_c,w01chronic_d,w01chronic_e,w01chronic_f,
           w01chronic_g,w01chronic_h,
           w01chronic_i,w01chronic_j,w01C068,w01C082,w01C085,w01smoke,w01alc,
           w01adl,w01C201,w01C203,w01C204,
           w01C205,w01C206,w01C207,w01iadl,w01C208,w01C209,w01C210,w01C211,
           w01C212,w01C213,w01C214,w01C215,w01C216,w01C217,
           w01mmseg,w01mmse,w01present_ecotype,
           w01present_labor,w01emp,
           w01ind,w01job,w01d_com037,w01d_com052,
           w01d_com130,w01wage ,
           w01selfemployed,w01agriculture ,w01sideline ,w01earned ,
           w01pinc,
           w01passets,
           w01pliabilities,w01pnetassets,
           w01hhinc,
           w01G026,w01G027,w01G028,w01G029,
           w01G030) -> w01

read.dta("data/Lt02.dta",convert.factors = FALSE) %>%
    select(pid,w02_fam1,w02edu,w02gender1,w02A002y,
           w02A002_age,w02marital,w02ecoact_s,w02A030,w02A032,
           w02region1,w02fromchildren,w02tochildren,w02fromparent,
           w02toparent,w02fromothers,w02toothers,w02transferfrom,
           w02transferto,w02chronic_sum,w02chronic_a,w02chronic_b,
           w02chronic_c,w02chronic_d,w02chronic_e,w02chronic_f,
           w02chronic_g,w02chronic_h,
           w02chronic_i,w02chronic_j,w02C068,w02C082,w02C085,w02smoke,w02alc,
           w02adl,w02C201,w02C203,w02C204,
           w02C205,w02C206,w02C207,w02iadl,w02C208,w02C209,w02C210,w02C211,
           w02C212,w02C213,w02C214,w02C215,w02C216,w02C217,
           w02mmseg,w02mmse,w02present_ecotype,
           w02present_labor,w02emp,
           w02ind,w02job,w02d_com037,w02d_com052,
           w02d_com128,w02d_com129,w02d_com130,w02wage ,
           w02selfemployed,w02agriculture ,w02sideline ,w02earned ,
           w02pinc,w02E201,w02E207,w02E213,
           w02E219,w02E225,w02E231,w02E237,
           w02E251,w02passets,
           w02pliabilities,w02pnetassets,
           w02hhinc,w02hhassets,w02hhliabilities,
           w02hhnetassets,w02G026,w02G027,w02G028,w02G029,
           w02G030) -> w02

read.dta("data/Lt03.dta",convert.factors = FALSE) %>%
    select(pid,w03_fam1,w03edu,w03gender1,w03A002y,
           w03A002_age,w03marital,w03ecoact_s,w03A030,w03A032,
           w03region1,w03fromchildren,w03tochildren,w03fromparent,
           w03toparent,w03fromothers,w03toothers,w03transferfrom,
           w03transferto,w03chronic_sum,w03chronic_a,w03chronic_b,
           w03chronic_c,w03chronic_d,w03chronic_e,w03chronic_f,
           w03chronic_g,w03chronic_h,
           w03chronic_i,w03chronic_j,w03C068,w03C082,w03C085,w03smoke,w03alc,
           w03adl,w03C201,w03C203,w03C204,
           w03C205,w03C206,w03C207,w03iadl,w03C208,w03C209,w03C210,w03C211,
           w03C212,w03C213,w03C214,w03C215,w03C216,w03C217,
           w03mmseg,w03mmse,w03present_ecotype,
           w03present_labor,w03emp,
           w03ind,w03job,w03d_com037,w03d_com052,
           w03d_com128,w03d_com129,w03d_com130,w03wage ,
           w03selfemployed,w03agriculture ,w03sideline ,w03earned ,
           w03pinc,w03E201,w03E207,w03E213,
           w03E219,w03E225,w03E231,w03E237,
           w03E251,w03passets,
           w03pliabilities,w03pnetassets,
           w03hhinc,w03hhassets,w03hhliabilities,
           w03hhnetassets,w03G026,w03G027,w03G028,w03G029,
           w03G030) -> w03

read.dta("data/Lt04.dta",convert.factors = FALSE) %>%
    select(pid,w04_fam1,w04edu,w04gender1,w04A002y,
           w04A002_age,w04marital,w04ecoact_s,w04A030,w04A032,
           w04region1,w04fromchildren,w04tochildren,w04fromparent,
           w04toparent,w04fromothers,w04toothers,w04transferfrom,
           w04transferto,w04chronic_sum,w04chronic_a,w04chronic_b,
           w04chronic_c,w04chronic_d,w04chronic_e,w04chronic_f,
           w04chronic_g,w04chronic_h,
           w04chronic_i,w04chronic_j,w04C068,w04C082,w04C085,w04smoke,w04alc,
           w04adl,w04C201,w04C203,w04C204,
           w04C205,w04C206,w04C207,w04iadl,w04C208,w04C209,w04C210,w04C211,
           w04C212,w04C213,w04C214,w04C215,w04C216,w04C217,
           w04mmseg,w04mmse,w04present_ecotype,
           w04present_labor,w04emp,
           w04ind,w04job,w04d_com037,w04d_com052,
           w04d_com128,w04d_com129,w04d_com130,w04wage ,
           w04selfemployed,w04agriculture ,w04sideline ,w04earned ,
           w04pinc,w04E201,w04E207,w04E213,
           w04E219,w04E225,w04E231,w04E237,
           w04E251,w04passets,
           w04pliabilities,w04pnetassets,
           w04hhinc,w04hhassets,w04hhliabilities,
           w04hhnetassets,w04G026,w04G027,w04G028,w04G029,
           w04G030) -> w04

read.dta("data/Lt05.dta",convert.factors = FALSE) %>%
    select(pid,w05_fam1,w05edu,w05gender1,w05A002y,
           w05A002_age,w05marital,w05ecoact_s,w05A030,w05A032,
           w05region1,w05fromchildren,w05tochildren,w05fromparent,
           w05toparent,w05fromothers,w05toothers,w05transferfrom,
           w05transferto,w05chronic_sum,w05chronic_a,w05chronic_b,
           w05chronic_c,w05chronic_d,w05chronic_e,w05chronic_f,
           w05chronic_g,w05chronic_h,
           w05chronic_i,w05chronic_j,w05C068,w05C082,w05C085,w05smoke,w05alc,
           w05adl,w05C201,w05C203,w05C204,
           w05C205,w05C206,w05C207,w05iadl,w05C208,w05C209,w05C210,w05C211,
           w05C212,w05C213,w05C214,w05C215,w05C216,w05C217,
           w05mmseg,w05mmse,w05present_ecotype,
           w05present_labor,w05emp,
           w05ind,w05job,w05d_com037,w05d_com052,
           w05d_com128,w05d_com129,w05d_com130,w05wage ,
           w05selfemployed,w05agriculture ,w05sideline ,w05earned ,
           w05pinc,w05E201,w05E207,w05E213,
           w05E219,w05E225,w05E231,w05E237,
           w05e251,w05passets,
           w05pliabilities,w05pnetassets,
           w05hhinc,w05hhassets,w05hhliabilities,
           w05hhnetassets,w05G026,w05G027,w05G028,w05G029,
           w05G030) -> w05


read.dta("data/Lt06.dta",convert.factors = FALSE) %>%    
    select(pid,w06_fam1,w06edu,w06gender1,w06A002y,
           w06A002_age,w06marital,w06ecoact_s,w06A030,w06A032,
           w06region1,w06fromchildren,w06tochildren,w06fromparent,
           w06toparent,w06fromothers,w06toothers,w06transferfrom,
           w06transferto,w06chronic_sum,w06chronic_a,w06chronic_b,
           w06chronic_c,w06chronic_d,w06chronic_e,w06chronic_f,
           w06chronic_g,w06chronic_h,
           w06chronic_i,w06chronic_j,w06C068,w06C082,w06C085,w06smoke,w06alc,
           w06adl,w06C201,w06C203,w06C204,
           w06C205,w06C206,w06C207,w06iadl,w06C208,w06C209,w06C210,w06C211,
           w06C212,w06C213,w06C214,w06C215,w06C216,w06C217,
           w06mmseg,w06mmse,w06present_ecotype,
           w06present_labor,w06emp,
           w06ind,w06job,w06d_com037,w06d_com052,
           w06d_com128,w06d_com129,w06d_com130,w06wage ,
           w06selfemployed,w06agriculture ,w06sideline ,w06earned ,
           w06pinc,w06E201,w06E207,w06E213,
           w06E219,w06E225,w06E231,w06E237,
           w06E251,w06passets,
           w06pliabilities,w06pnetassets,
           w06hhinc,w06hhassets,w06hhliabilities,
           w06hhnetassets,w06G026,w06G027,w06G028,w06G029,
           w06G030) -> w06


w01 %>%
    mutate(w01d_com128=NA) %>% mutate(w01d_com129=NA) %>%
    mutate(w01E201=NA) %>% mutate(w01E207=NA) %>%
    mutate(w01E213=NA) %>% mutate(w01E219=NA) %>%
    mutate(w01E225=NA) %>% mutate(w01E231=NA) %>%
    mutate(w01E237=NA) %>% mutate(w01E251=NA) %>%
    mutate(w01hhassets=NA) %>% mutate(w01hhliabilities=NA) %>%
    mutate(w01hhnetassets=NA) %>% mutate(year=2006)->w01


w02 %>% mutate(year=2008) -> w02
w03 %>% mutate(year=2010) -> w03
w04 %>% mutate(year=2012) -> w04
w05 %>% mutate(year=2014) -> w05
w06 %>% mutate(year=2016) -> w06


w01 %>%
    rename(pid=pid) %>% rename(age=w01A002_age) %>%
    rename(family=w01_fam1) %>% rename(edu=w01edu) %>%
    rename(gender=w01gender1) %>% rename(birth=w01A002y) %>%
    rename(marital=w01marital) %>% rename(emp_s=w01ecoact_s) %>%
    rename(religion=w01A030) %>% rename(meet=w01A032) %>%
    rename(region=w01region1) %>% rename(m_fromchildren=w01fromchildren) %>%
    rename(m_tochildren=w01tochildren) %>% rename(m_fromparent=w01fromparent) %>%
    rename(m_toparent=w01toparent) %>% rename(m_fromothers=w01fromothers) %>%
    rename(m_toothers=w01toothers) %>% rename(m_transferfrom=w01transferfrom) %>%
    rename(m_transferto=w01transferto) %>% rename(chronic_sum=w01chronic_sum) %>%
    rename(hypertension = w01chronic_a) %>% rename(diabetes =w01chronic_b) %>%
    rename(cancer=w01chronic_c) %>% rename(lung_disease=w01chronic_d) %>%
    rename(liver_disease=w01chronic_e) %>% rename(heart_disease=w01chronic_f) %>%
    rename(cerebrovascular_disease=w01chronic_g) %>% rename(mental_illness=w01chronic_h) %>%
    rename(arthritis=w01chronic_i) %>% rename(prostate_disease=w01chronic_j) %>%
    rename(incontinence=w01C068) %>% rename(hearing_aid=w01C082) %>%
    rename(dentures=w01C085) %>% rename(smoke=w01smoke) %>%
    rename(alcohol=w01alc) %>% rename(adl=w01adl) %>%
    rename(change_clothes=w01C201) %>% rename(bath=w01C203) %>%
    rename(meal=w01C204) %>% rename(out_of_room=w01C205) %>%
    rename(toilet=w01C206) %>% rename(iadl=w01iadl) %>%
    rename(prepare_meal=w01C210) %>% rename(buying=w01C214) %>%
    rename(m_manage=w01C215) %>% rename(phone_call=w01C216) %>%
    rename(urin=w01C207) %>% rename(gloom=w01C208) %>% 
    rename(clean=w01C209) %>% rename(laun=w01C211) %>% 
    rename(out=w01C212) %>% rename(bus=w01C213) %>% 
    rename(medicine=w01C217) %>% rename(mmseg=w01mmseg) %>%
    rename(mmse=w01mmse) %>% rename(present_ecotype=w01present_ecotype) %>%
    rename(present_labor=w01present_labor) %>% rename(emp=w01emp) %>%
    rename(industrial=w01ind) %>% rename(job=w01job) %>%
    rename(selfemployed_salary=w01d_com037) %>% rename(salary=w01d_com052) %>%
    rename(salary_requirement=w01d_com130) %>% rename(wage=w01wage) %>%
    rename(selfemployed=w01selfemployed) %>% rename(agriculture=w01agriculture) %>%
    rename(sideline=w01sideline) %>% rename(earned=w01earned) %>%
    rename(p_inc=w01pinc) %>% rename(p_assets=w01passets) %>%
    rename(p_liabilities=w01pliabilities) %>% rename(p_netassets=w01pnetassets) %>%
    rename(h_inc=w01hhinc) %>% rename(perceived_health=w01G026) %>%
    rename(perceived_eco=w01G027) %>% rename(spouse_relationship=w01G028) %>%
    rename(children_relationship=w01G029) %>% rename(QOL=w01G030) %>%
    rename(industrial_requirement=w01d_com128) %>% rename(job_requirement=w01d_com129) %>%
    rename(living_expenses=w01E201) %>% rename(food_expenses=w01E207) %>%
    rename(eating_out_expenses=w01E213) %>% rename(public_education_expenses=w01E219) %>%
    rename(private_education_expenses=w01E225) %>% rename(housing_expenses=w01E231) %>%
    rename(medical_expenses=w01E237) %>% rename(savings=w01E251) %>%
    rename(h_assets=w01hhassets) %>% rename(h_liabilities=w01hhliabilities) %>%
    rename(h_netassets=w01hhnetassets) -> w01

w02 %>%
    rename(pid=pid) %>% rename(age=w02A002_age) %>%
    rename(family=w02_fam1) %>% rename(edu=w02edu) %>%
    rename(gender=w02gender1) %>% rename(birth=w02A002y) %>%
    rename(marital=w02marital) %>% rename(emp_s=w02ecoact_s) %>%
    rename(religion=w02A030) %>% rename(meet=w02A032) %>%
    rename(region=w02region1) %>% rename(m_fromchildren=w02fromchildren) %>%
    rename(m_tochildren=w02tochildren) %>% rename(m_fromparent=w02fromparent) %>%
    rename(m_toparent=w02toparent) %>% rename(m_fromothers=w02fromothers) %>%
    rename(m_toothers=w02toothers) %>% rename(m_transferfrom=w02transferfrom) %>%
    rename(m_transferto=w02transferto) %>% rename(chronic_sum=w02chronic_sum) %>%
    rename(hypertension = w02chronic_a) %>% rename(diabetes =w02chronic_b) %>%
    rename(cancer=w02chronic_c) %>% rename(lung_disease=w02chronic_d) %>%
    rename(liver_disease=w02chronic_e) %>% rename(heart_disease=w02chronic_f) %>%
    rename(cerebrovascular_disease=w02chronic_g) %>% rename(mental_illness=w02chronic_h) %>%
    rename(arthritis=w02chronic_i) %>% rename(prostate_disease=w02chronic_j) %>%
    rename(incontinence=w02C068) %>% rename(hearing_aid=w02C082) %>%
    rename(dentures=w02C085) %>% rename(smoke=w02smoke) %>%
    rename(alcohol=w02alc) %>% rename(adl=w02adl) %>%
    rename(change_clothes=w02C201) %>% rename(bath=w02C203) %>%
    rename(meal=w02C204) %>% rename(out_of_room=w02C205) %>%
    rename(toilet=w02C206) %>% rename(iadl=w02iadl) %>%
    rename(prepare_meal=w02C210) %>% rename(buying=w02C214) %>%
    rename(m_manage=w02C215) %>% rename(phone_call=w02C216) %>%
    rename(urin=w02C207) %>% rename(gloom=w02C208) %>% 
    rename(clean=w02C209) %>% rename(laun=w02C211) %>% 
    rename(out=w02C212) %>% rename(bus=w02C213) %>% 
    rename(medicine=w02C217) %>% rename(mmseg=w02mmseg) %>%
    rename(mmse=w02mmse) %>% rename(present_ecotype=w02present_ecotype) %>%
    rename(present_labor=w02present_labor) %>% rename(emp=w02emp) %>%
    rename(industrial=w02ind) %>% rename(job=w02job) %>%
    rename(selfemployed_salary=w02d_com037) %>% rename(salary=w02d_com052) %>%
    rename(salary_requirement=w02d_com130) %>% rename(wage=w02wage) %>%
    rename(selfemployed=w02selfemployed) %>% rename(agriculture=w02agriculture) %>%
    rename(sideline=w02sideline) %>% rename(earned=w02earned) %>%
    rename(p_inc=w02pinc) %>% rename(p_assets=w02passets) %>%
    rename(p_liabilities=w02pliabilities) %>% rename(p_netassets=w02pnetassets) %>%
    rename(h_inc=w02hhinc) %>% rename(perceived_health=w02G026) %>%
    rename(perceived_eco=w02G027) %>% rename(spouse_relationship=w02G028) %>%
    rename(children_relationship=w02G029) %>% rename(QOL=w02G030) %>%
    rename(industrial_requirement=w02d_com128) %>% rename(job_requirement=w02d_com129) %>%
    rename(living_expenses=w02E201) %>% rename(food_expenses=w02E207) %>%
    rename(eating_out_expenses=w02E213) %>% rename(public_education_expenses=w02E219) %>%
    rename(private_education_expenses=w02E225) %>% rename(housing_expenses=w02E231) %>%
    rename(medical_expenses=w02E237) %>% rename(savings=w02E251) %>%
    rename(h_assets=w02hhassets) %>% rename(h_liabilities=w02hhliabilities) %>%
    rename(h_netassets=w02hhnetassets) -> w02

w03 %>%
    rename(pid=pid) %>% rename(age=w03A002_age) %>%
    rename(family=w03_fam1) %>% rename(edu=w03edu) %>%
    rename(gender=w03gender1) %>% rename(birth=w03A002y) %>%
    rename(marital=w03marital) %>% rename(emp_s=w03ecoact_s) %>%
    rename(religion=w03A030) %>% rename(meet=w03A032) %>%
    rename(region=w03region1) %>% rename(m_fromchildren=w03fromchildren) %>%
    rename(m_tochildren=w03tochildren) %>% rename(m_fromparent=w03fromparent) %>%
    rename(m_toparent=w03toparent) %>% rename(m_fromothers=w03fromothers) %>%
    rename(m_toothers=w03toothers) %>% rename(m_transferfrom=w03transferfrom) %>%
    rename(m_transferto=w03transferto) %>% rename(chronic_sum=w03chronic_sum) %>%
    rename(hypertension = w03chronic_a) %>% rename(diabetes =w03chronic_b) %>%
    rename(cancer=w03chronic_c) %>% rename(lung_disease=w03chronic_d) %>%
    rename(liver_disease=w03chronic_e) %>% rename(heart_disease=w03chronic_f) %>%
    rename(cerebrovascular_disease=w03chronic_g) %>% rename(mental_illness=w03chronic_h) %>%
    rename(arthritis=w03chronic_i) %>% rename(prostate_disease=w03chronic_j) %>%
    rename(incontinence=w03C068) %>% rename(hearing_aid=w03C082) %>%
    rename(dentures=w03C085) %>% rename(smoke=w03smoke) %>%
    rename(alcohol=w03alc) %>% rename(adl=w03adl) %>%
    rename(change_clothes=w03C201) %>% rename(bath=w03C203) %>%
    rename(meal=w03C204) %>% rename(out_of_room=w03C205) %>%
    rename(toilet=w03C206) %>% rename(iadl=w03iadl) %>%
    rename(prepare_meal=w03C210) %>% rename(buying=w03C214) %>%
    rename(m_manage=w03C215) %>% rename(phone_call=w03C216) %>%
    rename(urin=w03C207) %>% rename(gloom=w03C208) %>% 
    rename(clean=w03C209) %>% rename(laun=w03C211) %>% 
    rename(out=w03C212) %>% rename(bus=w03C213) %>% 
    rename(medicine=w03C217) %>% rename(mmseg=w03mmseg) %>%
    rename(mmse=w03mmse) %>% rename(present_ecotype=w03present_ecotype) %>%
    rename(present_labor=w03present_labor) %>% rename(emp=w03emp) %>%
    rename(industrial=w03ind) %>% rename(job=w03job) %>%
    rename(selfemployed_salary=w03d_com037) %>% rename(salary=w03d_com052) %>%
    rename(salary_requirement=w03d_com130) %>% rename(wage=w03wage) %>%
    rename(selfemployed=w03selfemployed) %>% rename(agriculture=w03agriculture) %>%
    rename(sideline=w03sideline) %>% rename(earned=w03earned) %>%
    rename(p_inc=w03pinc) %>% rename(p_assets=w03passets) %>%
    rename(p_liabilities=w03pliabilities) %>% rename(p_netassets=w03pnetassets) %>%
    rename(h_inc=w03hhinc) %>% rename(perceived_health=w03G026) %>%
    rename(perceived_eco=w03G027) %>% rename(spouse_relationship=w03G028) %>%
    rename(children_relationship=w03G029) %>% rename(QOL=w03G030) %>%
    rename(industrial_requirement=w03d_com128) %>% rename(job_requirement=w03d_com129) %>%
    rename(living_expenses=w03E201) %>% rename(food_expenses=w03E207) %>%
    rename(eating_out_expenses=w03E213) %>% rename(public_education_expenses=w03E219) %>%
    rename(private_education_expenses=w03E225) %>% rename(housing_expenses=w03E231) %>%
    rename(medical_expenses=w03E237) %>% rename(savings=w03E251) %>%
    rename(h_assets=w03hhassets) %>% rename(h_liabilities=w03hhliabilities) %>%
    rename(h_netassets=w03hhnetassets) -> w03


w04 %>%
    rename(pid=pid) %>% rename(age=w04A002_age) %>%
    rename(family=w04_fam1) %>% rename(edu=w04edu) %>%
    rename(gender=w04gender1) %>% rename(birth=w04A002y) %>%
    rename(marital=w04marital) %>% rename(emp_s=w04ecoact_s) %>%
    rename(religion=w04A030) %>% rename(meet=w04A032) %>%
    rename(region=w04region1) %>% rename(m_fromchildren=w04fromchildren) %>%
    rename(m_tochildren=w04tochildren) %>% rename(m_fromparent=w04fromparent) %>%
    rename(m_toparent=w04toparent) %>% rename(m_fromothers=w04fromothers) %>%
    rename(m_toothers=w04toothers) %>% rename(m_transferfrom=w04transferfrom) %>%
    rename(m_transferto=w04transferto) %>% rename(chronic_sum=w04chronic_sum) %>%
    rename(hypertension = w04chronic_a) %>% rename(diabetes =w04chronic_b) %>%
    rename(cancer=w04chronic_c) %>% rename(lung_disease=w04chronic_d) %>%
    rename(liver_disease=w04chronic_e) %>% rename(heart_disease=w04chronic_f) %>%
    rename(cerebrovascular_disease=w04chronic_g) %>% rename(mental_illness=w04chronic_h) %>%
    rename(arthritis=w04chronic_i) %>% rename(prostate_disease=w04chronic_j) %>%
    rename(incontinence=w04C068) %>% rename(hearing_aid=w04C082) %>%
    rename(dentures=w04C085) %>% rename(smoke=w04smoke) %>%
    rename(alcohol=w04alc) %>% rename(adl=w04adl) %>%
    rename(change_clothes=w04C201) %>% rename(bath=w04C203) %>%
    rename(meal=w04C204) %>% rename(out_of_room=w04C205) %>%
    rename(toilet=w04C206) %>% rename(iadl=w04iadl) %>%
    rename(prepare_meal=w04C210) %>% rename(buying=w04C214) %>%
    rename(m_manage=w04C215) %>% rename(phone_call=w04C216) %>%
    rename(urin=w04C207) %>% rename(gloom=w04C208) %>% 
    rename(clean=w04C209) %>% rename(laun=w04C211) %>% 
    rename(out=w04C212) %>% rename(bus=w04C213) %>% 
    rename(medicine=w04C217) %>% rename(mmseg=w04mmseg) %>%
    rename(mmse=w04mmse) %>% rename(present_ecotype=w04present_ecotype) %>%
    rename(present_labor=w04present_labor) %>% rename(emp=w04emp) %>%
    rename(industrial=w04ind) %>% rename(job=w04job) %>%
    rename(selfemployed_salary=w04d_com037) %>% rename(salary=w04d_com052) %>%
    rename(salary_requirement=w04d_com130) %>% rename(wage=w04wage) %>%
    rename(selfemployed=w04selfemployed) %>% rename(agriculture=w04agriculture) %>%
    rename(sideline=w04sideline) %>% rename(earned=w04earned) %>%
    rename(p_inc=w04pinc) %>% rename(p_assets=w04passets) %>%
    rename(p_liabilities=w04pliabilities) %>% rename(p_netassets=w04pnetassets) %>%
    rename(h_inc=w04hhinc) %>% rename(perceived_health=w04G026) %>%
    rename(perceived_eco=w04G027) %>% rename(spouse_relationship=w04G028) %>%
    rename(children_relationship=w04G029) %>% rename(QOL=w04G030) %>%
    rename(industrial_requirement=w04d_com128) %>% rename(job_requirement=w04d_com129) %>%
    rename(living_expenses=w04E201) %>% rename(food_expenses=w04E207) %>%
    rename(eating_out_expenses=w04E213) %>% rename(public_education_expenses=w04E219) %>%
    rename(private_education_expenses=w04E225) %>% rename(housing_expenses=w04E231) %>%
    rename(medical_expenses=w04E237) %>% rename(savings=w04E251) %>%
    rename(h_assets=w04hhassets) %>% rename(h_liabilities=w04hhliabilities) %>%
    rename(h_netassets=w04hhnetassets) -> w04



w05 %>%
    rename(pid=pid) %>% rename(age=w05A002_age) %>%
    rename(family=w05_fam1) %>% rename(edu=w05edu) %>%
    rename(gender=w05gender1) %>% rename(birth=w05A002y) %>%
    rename(marital=w05marital) %>% rename(emp_s=w05ecoact_s) %>%
    rename(religion=w05A030) %>% rename(meet=w05A032) %>%
    rename(region=w05region1) %>% rename(m_fromchildren=w05fromchildren) %>%
    rename(m_tochildren=w05tochildren) %>% rename(m_fromparent=w05fromparent) %>%
    rename(m_toparent=w05toparent) %>% rename(m_fromothers=w05fromothers) %>%
    rename(m_toothers=w05toothers) %>% rename(m_transferfrom=w05transferfrom) %>%
    rename(m_transferto=w05transferto) %>% rename(chronic_sum=w05chronic_sum) %>%
    rename(hypertension = w05chronic_a) %>% rename(diabetes =w05chronic_b) %>%
    rename(cancer=w05chronic_c) %>% rename(lung_disease=w05chronic_d) %>%
    rename(liver_disease=w05chronic_e) %>% rename(heart_disease=w05chronic_f) %>%
    rename(cerebrovascular_disease=w05chronic_g) %>% rename(mental_illness=w05chronic_h) %>%
    rename(arthritis=w05chronic_i) %>% rename(prostate_disease=w05chronic_j) %>%
    rename(incontinence=w05C068) %>% rename(hearing_aid=w05C082) %>%
    rename(dentures=w05C085) %>% rename(smoke=w05smoke) %>%
    rename(alcohol=w05alc) %>% rename(adl=w05adl) %>%
    rename(change_clothes=w05C201) %>% rename(bath=w05C203) %>%
    rename(meal=w05C204) %>% rename(out_of_room=w05C205) %>%
    rename(toilet=w05C206) %>% rename(iadl=w05iadl) %>%
    rename(prepare_meal=w05C210) %>% rename(buying=w05C214) %>%
    rename(m_manage=w05C215) %>% rename(phone_call=w05C216) %>%
    rename(urin=w05C207) %>% rename(gloom=w05C208) %>% 
    rename(clean=w05C209) %>% rename(laun=w05C211) %>% 
    rename(out=w05C212) %>% rename(bus=w05C213) %>% 
    rename(medicine=w05C217) %>% rename(mmseg=w05mmseg) %>%
    rename(mmse=w05mmse) %>% rename(present_ecotype=w05present_ecotype) %>%
    rename(present_labor=w05present_labor) %>% rename(emp=w05emp) %>%
    rename(industrial=w05ind) %>% rename(job=w05job) %>%
    rename(selfemployed_salary=w05d_com037) %>% rename(salary=w05d_com052) %>%
    rename(salary_requirement=w05d_com130) %>% rename(wage=w05wage) %>%
    rename(selfemployed=w05selfemployed) %>% rename(agriculture=w05agriculture) %>%
    rename(sideline=w05sideline) %>% rename(earned=w05earned) %>%
    rename(p_inc=w05pinc) %>% rename(p_assets=w05passets) %>%
    rename(p_liabilities=w05pliabilities) %>% rename(p_netassets=w05pnetassets) %>%
    rename(h_inc=w05hhinc) %>% rename(perceived_health=w05G026) %>%
    rename(perceived_eco=w05G027) %>% rename(spouse_relationship=w05G028) %>%
    rename(children_relationship=w05G029) %>% rename(QOL=w05G030) %>%
    rename(industrial_requirement=w05d_com128) %>% rename(job_requirement=w05d_com129) %>%
    rename(living_expenses=w05E201) %>% rename(food_expenses=w05E207) %>%
    rename(eating_out_expenses=w05E213) %>% rename(public_education_expenses=w05E219) %>%
    rename(private_education_expenses=w05E225) %>% rename(housing_expenses=w05E231) %>%
    rename(medical_expenses=w05E237) %>% rename(savings=w05e251) %>%
    rename(h_assets=w05hhassets) %>% rename(h_liabilities=w05hhliabilities) %>%
    rename(h_netassets=w05hhnetassets) -> w05


w06 %>%
    rename(pid=pid) %>% rename(age=w06A002_age) %>%
    rename(family=w06_fam1) %>% rename(edu=w06edu) %>%
    rename(gender=w06gender1) %>% rename(birth=w06A002y) %>%
    rename(marital=w06marital) %>% rename(emp_s=w06ecoact_s) %>%
    rename(religion=w06A030) %>% rename(meet=w06A032) %>%
    rename(region=w06region1) %>% rename(m_fromchildren=w06fromchildren) %>%
    rename(m_tochildren=w06tochildren) %>% rename(m_fromparent=w06fromparent) %>%
    rename(m_toparent=w06toparent) %>% rename(m_fromothers=w06fromothers) %>%
    rename(m_toothers=w06toothers) %>% rename(m_transferfrom=w06transferfrom) %>%
    rename(m_transferto=w06transferto) %>% rename(chronic_sum=w06chronic_sum) %>%
    rename(hypertension = w06chronic_a) %>% rename(diabetes =w06chronic_b) %>%
    rename(cancer=w06chronic_c) %>% rename(lung_disease=w06chronic_d) %>%
    rename(liver_disease=w06chronic_e) %>% rename(heart_disease=w06chronic_f) %>%
    rename(cerebrovascular_disease=w06chronic_g) %>% rename(mental_illness=w06chronic_h) %>%
    rename(arthritis=w06chronic_i) %>% rename(prostate_disease=w06chronic_j) %>%
    rename(incontinence=w06C068) %>% rename(hearing_aid=w06C082) %>%
    rename(dentures=w06C085) %>% rename(smoke=w06smoke) %>%
    rename(alcohol=w06alc) %>% rename(adl=w06adl) %>%
    rename(change_clothes=w06C201) %>% rename(bath=w06C203) %>%
    rename(meal=w06C204) %>% rename(out_of_room=w06C205) %>%
    rename(toilet=w06C206) %>% rename(iadl=w06iadl) %>%
    rename(prepare_meal=w06C210) %>% rename(buying=w06C214) %>%
    rename(m_manage=w06C215) %>% rename(phone_call=w06C216) %>%
    rename(urin=w06C207) %>% rename(gloom=w06C208) %>% 
    rename(clean=w06C209) %>% rename(laun=w06C211) %>% 
    rename(out=w06C212) %>% rename(bus=w06C213) %>% 
    rename(medicine=w06C217) %>% rename(mmseg=w06mmseg) %>%
    rename(mmse=w06mmse) %>% rename(present_ecotype=w06present_ecotype) %>%
    rename(present_labor=w06present_labor) %>% rename(emp=w06emp) %>%
    rename(industrial=w06ind) %>% rename(job=w06job) %>%
    rename(selfemployed_salary=w06d_com037) %>% rename(salary=w06d_com052) %>%
    rename(salary_requirement=w06d_com130) %>% rename(wage=w06wage) %>%
    rename(selfemployed=w06selfemployed) %>% rename(agriculture=w06agriculture) %>%
    rename(sideline=w06sideline) %>% rename(earned=w06earned) %>%
    rename(p_inc=w06pinc) %>% rename(p_assets=w06passets) %>%
    rename(p_liabilities=w06pliabilities) %>% rename(p_netassets=w06pnetassets) %>%
    rename(h_inc=w06hhinc) %>% rename(perceived_health=w06G026) %>%
    rename(perceived_eco=w06G027) %>% rename(spouse_relationship=w06G028) %>%
    rename(children_relationship=w06G029) %>% rename(QOL=w06G030) %>%
    rename(industrial_requirement=w06d_com128) %>% rename(job_requirement=w06d_com129) %>%
    rename(living_expenses=w06E201) %>% rename(food_expenses=w06E207) %>%
    rename(eating_out_expenses=w06E213) %>% rename(public_education_expenses=w06E219) %>%
    rename(private_education_expenses=w06E225) %>% rename(housing_expenses=w06E231) %>%
    rename(medical_expenses=w06E237) %>% rename(savings=w06E251) %>%
    rename(h_assets=w06hhassets) %>% rename(h_liabilities=w06hhliabilities) %>%
    rename(h_netassets=w06hhnetassets) -> w06

klosa <- rbind(w01,w02,w03,w04,w05,w06)

#성별구분 # ageg변수 만들기~50s,50s,60s,70s,80s이상 # regiong변수 만들기
klosa %<>% mutate(gender=ifelse(gender==1, "male","female")) %>% 
    mutate(regiong=ifelse(region==11,'Seoul',
                          ifelse(region==23 |region==31, 'incheon/gyeonggi',
                                 ifelse(region==21|region==38|region==26,'Busan/Gyeongnam/Ulsan',
                                        ifelse(region==22|region==37,'Daegu/Gyeongbuk',
                                               ifelse(region==25|region==27|region==34,'Daejeon/Sejong/Chungnam', 
                                                      ifelse(region==32|region==33,'Kangwon/Chungbuk','Gwangju/Jeonnam/Jeonbuk' ))))))) %>%   
    mutate(ageg = ifelse(age < 50, '~50s', 
                         ifelse(age < 60, '50s', 
                                ifelse(age < 70, '60s', 
                                       ifelse(age < 80, '70s','80s~')))))


write.csv(klosa,file="Data/klosa.csv")

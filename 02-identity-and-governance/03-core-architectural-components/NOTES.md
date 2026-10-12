# Summary: Describe Core Architectural Components of Azure

## 1. Introduction
* **Cilj:** Razumijevanje osnovne fizičke i upravljačke (management) strukture Microsoft Azure platforme.
* **Ključni koncepti:** Fizička infrastruktura (datacentri, regije, zone dostupnosti) i upravljačka infrastruktura (resursi, resursne grupe, pretplate, management grupe).

---

## 2. What is Microsoft Azure?
* **Definicija:** Azure je skup cloud servisa koji raste i pomaže organizacijama da odgovore na poslovne izazove.
* **Model rada:** Omogućuje izgradnju, upravljanje i deployment aplikacija na masovnoj, globalnoj mreži koristeći omiljene alate i okvire (frameworks).
* **Prednosti:** Agilnost, skalabilnost, fleksibilnost i prelazak s CapEx na OpEx model financiranja.

---

## 3. Get Started with Azure Accounts
* **Azure Tenant / Entra ID:** Centralni identifikacijski sustav vezan uz organizaciju.
* **Azure Account:** Korisnički račun koji daje pristup Azure servisima i služi kao osnova za kreiranje pretplata.
* **Korisničke opcije:**
  * **Free Account:** Besplatni krediti za prvih 30 dana + pristup besplatnim servisima na 12 mjeseci + 55+ stalno besplatnih servisa.
  * **Pay-As-You-Go:** Plaćanje po stvarnoj potrošnji bez unaprijed definiranih obveza.
  * **Student / Enterprise Agreements (EA):** Posebni ugovori i popusti prilagođeni specifičnim skupinama ili velikim tvrtkama.

---

## 4. Describe Azure Physical Infrastructure
* **Datacenters (Podatkovni centri):** Fizičke zgrade sa poslužiteljima, napajanjem, hlađenjem i mrežnom opremom.
* **Regions (Regije):**
  * Geografska područja unutar kojih se nalazi jedan ili više podatkovnih centara povezanih mrežom niske latencije.
  * Osiguravaju fleksibilnost, usklađenost s lokalnim zakonima o podacima (data residency) i blizinu korisnicima.
  * **Region Pairs:** Većina regija ima uparenu drugu regiju unutar iste geografije (udaljenu barem 300 milja) radi zaštite od elementarnih nepogoda i planiranih održavanja.
* **Availability Zones (Zone dostupnosti):**
  * Fizički odvojeni podatkovni centri unutar iste Azure regije.
  * Svaka zona ima nezavisno napajanje, hlađenje i mrežu.
  * Služe za postizanje visoke dostupnosti (**High Availability**) i otpornosti na ispad pojedinačnog objekta (SLA do 99.99%).

---

## 5. Describe Azure Management Infrastructure
* **Resources (Resursi):** Osnovni građevni blokovi Azurea (Compute VMs, Storage Accounts, Virtual Networks, Databases).
* **Resource Groups (Resursne grupe):**
  * Logički kontejneri u koje se grupiraju resursi koji dijele isti životni ciklus (kreiranje, ažuriranje, brisanje).
  * Svaki resurs može pripadati **samo jednoj** resursnoj grupi.
* **Subscriptions (Pretplate):**
  * Jedinica za upravljanje, sigurnost i naplatu.
  * Povezuje Azure račune s resursima i definira granice potrošnje (Cost Control) te pristupa (RBAC).
* **Management Groups (Management grupe):**
  * Hijerarhijske strukture iznad pretplata.
  * Omogućuju primjenu upravljačkih politika (Azure Policy), usklađenosti i pravila pristupa (RBAC) na više pretplata odjednom.
  * **Hijerarhija:** Root Management Group -> Management Groups -> Subscriptions -> Resource Groups -> Resources.

---

## 6. Knowledge Check & Summary
* **Ključni zaključci:**
  1. Fizička struktura (Datacenters -> Availability Zones -> Regions) osigurava otpornost i visoku dostupnost.
  2. Upravljačka struktura (Management Groups -> Subscriptions -> Resource Groups -> Resources) omogućuje strog governance, kontrolu troškova i organizaciju prava pristupa.
  3. Razumijevanje ovih komponenti temelj je za izgradnju bilo koje scalable i sigurne enterprise arhitekture.
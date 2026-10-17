# Sažetak: Sovereignty Policy Initiatives in Azure

Ovaj modul objašnjava kako pomoću usluge **Azure Policy** i **Azure Policy Inicijativa (Policy Initiatives)** uspostaviti kontrolu, sigurnosne granice i usklađenost s nacionalnim i regionalnim regulatornim zahtjevima te standardima suvereniteta podataka (*Sovereignty*).

---

## 1. Overview (Pregled)
* **Azure Policy**: Usluga koja omogućuje stvaranje, dodjelu i upravljanje politikama upravljanja (*governance*) radi osiguranja usklađenosti resursa s organizacijskim standardima.
* **Azure Policy Initiatives**: Grupirane definicije više pojedinačnih politika usmjerene prema zajedničkom cilju ili regulatornom okviru (npr. *Sovereignty*, public sector, financijski propisi).
* **Svrha**: Ubrzanje digitalne transformacije u javnom sektoru i reguliranim industrijama smanjenjem vremena potrebnog za reviziju (*audit*) te automatskim provođenjem sigurnosnih pravila (*guardrails*).

---

## 2. Cloud Adoption Framework (CAF) for Azure
* **CAF Govern metodologija**: Pruža sustavan okvir za uspostavu i kontinuirano unapređenje upravljanja cloudom kroz 5 koraka:
  1. *Build a governance team* (Izgradnja tima)
  2. *Assess cloud risks* (Procjena poslovnih i tehničkih rizika)
  3. *Document cloud governance policies* (Dokumentiranje politika)
  4. *Enforce cloud governance policies* (Provođenje politika automatiziranim alatima)
  5. *Monitor cloud governance* (Kontinuirani nadzor)
* **5 ključnih disciplina upravljanja**:
  * **Cost Management** (Upravljanje troškovima)
  * **Security Baseline** (Sigurnosni temelji)
  * **Resource Consistency** (Konzistentnost resursa i oznaka)
  * **Identity Baseline** (Upravljanje identitetima i pristupom)
  * **Deployment Acceleration** (Automatizacija i ubrzanje deploymenta)
* **Uloga Azure Policyja u CAF-u**: Služi kao primarni alat za uspostavu granica (*guardrails*), sprječavanje loših konfiguracija, automatsku remedijaciju i praćenje usklađenosti putem nadzorne ploče (*compliance dashboard*).

---

## 3. Azure Policy Design Principles (Principi dizajna)
* **Hijerarhija upravljanja (Governance Hierarchy)**:
  * **Tenant Root Group → Management Groups (do 6 razina) → Subscriptions → Resource Groups → Resources**.
  * Pravila definirana na višim razinama automatski se **nasljeđuju** na nižim razinama scope-a.
* **Control Plane vs. Data Plane**:
  * **Control Plane (Azure Resource Manager - ARM)**: Upravlja operacijama nad resursima (stvaranje, brisanje, ažuriranje). Azure Policy primarno djeluje na Control Plane razini (nakon RBAC provjere).
  * **Data Plane**: Izravna interakcija s podacima unutar resursa (npr. Key Vault tajne, SQL upiti, Kubernetes pods). Podržana je kroz specifične *Resource Provider modove* (npr. `Microsoft.KeyVault.Data`, `Microsoft.Kubernetes.Data`).
* **Scenariji evaluacije (Greenfield vs. Brownfield)**:
  * **Greenfield (Policy-first)**: Evaluacija se vrši u realnom vremenu prilikom stvaranja ili ažuriranja resursa.
  * **Brownfield (Resource-first)**: Primjena nove politike na postojeće resurse. Evaluacija se vrši putem *compliance scana* svakih 24 h (ili ručnim pokretanjem). Neusklađeni resursi se označe, ali se ne brišu automatski.

---

## 4. Azure Policy Resources (Resursi i pojmovi)
U sklopu Azure Policy sustava razlikujemo 6 ključnih resursa/pojmova:
1. **Definitions (Definicije)**: JSON datoteke koje opisuju uvjete usklađenosti i efekte (akcije). Mogu biti *Built-in* ili *Custom*.
2. **Initiatives (Inicijative)**: Skupine povezanih definicija (također u JSON-u). Poznate i kao *Policy Sets*.
3. **Assignments (Dodjele)**: Primjena definicije ili inicijative na određeni *scope* (Management Group, Subscription ili Resource Group).
   * Podržavaju *Parameters*, *Enforcement Mode* (omogućuje "What-if" analizu bez blokiranja), *Excluded Scopes* (izuzete opsege) i *Resource Selectors*.
4. **Exemptions (Iznimke)**: Privremeno ili trajno izuzimanje resursa od evaluacije. Razvrstavaju se u:
   * **Mitigated**: Cilj je ispunjen na drugi način.
   * **Waiver**: Privremeno prihvaćen rizik neusklađenosti.
5. **Attestations (Potvrde)**: Koriste se za ručne politike (*Manual policies*) kako bi se potvrdio status usklađenosti resursa koji se ne mogu automatski evaluirati.
6. **Remediations (Remedijacije)**: Automatsko ili ručno dovođenje neusklađenih resursa u usklađeno stanje (za efekte `deployIfNotExists` i `modify`).

---

## 5. Azure Policy Definitions (Anatomija i struktura definicija)
Struktura JSON definicije uključuje:
* **metadata / displayName / description**: Osnovni podaci i kategorizacija.
* **mode**: Određuje evaluira li se ARM resurs (`Indexed`, `All`) ili Data Plane resurs (`Microsoft.KeyVault.Data`, itd.).
* **parameters**: Omogućuju višekratnu upotrebu iste politike s različitim vrijednostima (npr. dopuštene regije).
* **policyRule**: Sadrži **`if`** i **`then`** blokove:
  * **`if` (Uvjeti)**: Koristi logičke operatore (`allOf`, `anyOf`, `not`) te usmjerava evaluaciju na polja (`field`), vrijednosti (`value`) ili brojače (`count`).
  * **`then` (Efekti)**: Određuje što se događa kada su uvjeti ispunjeni.

### Primarni efekti politike (`effects`):
* **`Deny`**: Blokira stvaranje/ažuriranje neusklađenog resursa.
* **`Disabled`**: Isključuje evaluaciju pravila.
* **`Audit` / `AuditIfNotExists`**: Stvara upozorenje/log o neusklađenosti bez blokiranja akcije.
* **`Append`**: Dodaje obavezna polja/svojstva na resurs tijekom stvaranja.
* **`Modify`**: Dodaje, mijenja ili uklanja svojstva i tagove na resursu.
* **`DeployIfNotExists`**: Automatski dodaje nedostajući povezani resurs (npr. dijagnostičke postavke).
* **`Manual`**: Zahtijeva ručnu potvrdnicu (attestation) usklađenosti.

---

## 6. Evaluacija, Provjera i Sažetak Modula
* **Proces evaluacije**: Izvršava se prilikom ARM zahtjeva (Greenfield) te u sklopu periodičkih skeniranja (Brownfield).
* **Sovereignty Portfolio**: Microsoft nudi prilagođene *custom policy initiatives* i *compliance mappings* putem otvorenog koda (**industry-policy-portfolio** repozitorij na GitHubu) za zadovoljavanje specifičnih nacionalnih i regionalnih zahtjeva suvereniteta i zaštite podataka.
* **Zaključak**: Kombiniranjem pravilno usmjerene hijerarhije upravljanja, prilagođenih inicijativa te automatskih remedijacija, organizacije mogu u potpunosti zaštititi svoje cloud okruženje i zadovoljiti stroge regulatorne uvjete bez usporavanja razvoja.
public with sharing class BusinessCardController {

    // ----------------------------------------------------------
    // STEP 1 — Call Einstein → returns JSON string
    // ----------------------------------------------------------
    @AuraEnabled
    public static String extractFromCard(String contentDocumentId) {
        return AI_businessCardAnalyzer.extractInformation(contentDocumentId);
    }

    // ----------------------------------------------------------
    // STEP 2 — Search for existing Lead by email
    // ----------------------------------------------------------
    @AuraEnabled
    public static Lead findLead(String email) {
        if (String.isBlank(email)) return null;

        List<Lead> leads = [
            SELECT Id, FirstName, LastName, Company, Email
            FROM Lead WHERE Email = :email LIMIT 1
        ];
        return leads.isEmpty() ? null : leads[0];
    }

    // ----------------------------------------------------------
    // STEP 3A — Create new Lead
    // ----------------------------------------------------------
    @AuraEnabled
    public static Id createLead(String extractedJson) {

        Map<String, Object> data = (Map<String, Object>) JSON.deserializeUntyped(extractedJson);

        Lead l = new Lead();
        parseLeadFields(l, data);

        insert l;
        return l.Id;
    }

    // ----------------------------------------------------------
    // STEP 3B — Update existing Lead
    // ----------------------------------------------------------
    @AuraEnabled
    public static Id updateLead(String extractedJson, Id existingLeadId) {

        Lead l = new Lead(Id = existingLeadId);

        Map<String, Object> data = (Map<String, Object>) JSON.deserializeUntyped(extractedJson);
        parseLeadFields(l, data);

        update l;
        return l.Id;
    }

    // ----------------------------------------------------------
    // Shared parser
    // ----------------------------------------------------------
    private static void parseLeadFields(Lead l, Map<String, Object> data) {
        String full = (String) data.get('fullName');
        if (String.isNotBlank(full)) {
            List<String> parts = full.split(' ', 2);
            l.FirstName = parts.size() > 1 ? parts[0] : '';
            l.LastName  = parts.size() > 1 ? parts[1] : parts[0];
        }

        l.Company = (String) data.get('company');
        l.Email   = (String) data.get('email');
        l.Phone   = (String) data.get('phone');
        l.MobilePhone = (String) data.get('mobile');
        l.Title   = (String) data.get('jobTitle');

        l.Street  = (String) data.get('street');
        l.City    = (String) data.get('city');
        l.State   = (String) data.get('state');
        l.PostalCode = (String) data.get('postalCode');
        l.Country = (String) data.get('country');
    }
}
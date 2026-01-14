import models.io.crossplane.apiextensions.v1 as apiextensions

e2etest = apiextensions.E2ETest {
    metadata.name = "e2etest-keda"
    spec = {
        compositionPath = "../../apis/kedas/composition.yaml"
        xrdPath = "../../apis/kedas/definition.yaml"
        timeoutSeconds = 300
        skipDelete = False
        claimPath = "claim.yaml"
    }
}

import org.apache.ofbiz.base.util.UtilMisc
import org.apache.ofbiz.service.ServiceUtil

Map FetchQuantityProducedPaged() {
    Delegator delegator = (Delegator) dctx.getDelegator()

    int page = (ctx.page ?: "1") as int
    int limit = (ctx.limit ?: "10") as int
    int offset = (page - 1) * limit

    List list = delegator.findList("WorkEffort", null, null, null, null, false)
    int total = list.size()
    int totalPages = Math.ceil(total / limit) as int

    List pageList = list.subList(offset, Math.min(offset + limit, total))

    List labels = []
    List planned = []
    List actual = []

    pageList.each { we ->
        labels.add(we.workEffortId ?: "")
        planned.add((we.quantityToProduce ?: 0.0) as Double)
        actual.add((we.quantityProduced ?: 0.0) as Double)
    }

    Map result = ServiceUtil.returnSuccess()
    result.labels = labels
    result.planned = planned
    result.actual = actual
    result.totalPages = totalPages
    return result
}

def ListMonthlyReworkRejectedStats() {

    Delegator delegator = (Delegator) context.delegator
    List<Map> statsList = []

    // Loop 12 months (Jan–Dec)
    (1..12).each { month ->
        // Fetch rework count
        def rework = delegator.findCountByCondition(
            "WorkEffort",
            EntityCondition.makeCondition([
                EntityCondition.makeCondition("month", EntityOperator.EQUALS, month),
                EntityCondition.makeCondition("workEffortTypeId", EntityOperator.EQUALS, "REWORK")
            ], EntityOperator.AND),
            null,
            null
        )

        // Fetch rejected count
        def rejected = delegator.findCountByCondition(
            "WorkEffort",
            EntityCondition.makeCondition([
                EntityCondition.makeCondition("month", EntityOperator.EQUALS, month),
                EntityCondition.makeCondition("workEffortTypeId", EntityOperator.EQUALS, "REJECTED")
            ], EntityOperator.AND),
            null,
            null
        )

        statsList.add([
            monthName     : ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"][month - 1],
            reworkCount   : rework,
            rejectedCount : rejected
        ])
    }

    result.monthlyReworkRejectedStats = statsList
    result.responseMessage = "success"
    return result
}